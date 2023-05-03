import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.swing.event.InternalFrameAdapter;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.util.*;

public class CSVtoXML {

    protected DocumentBuilderFactory domFactory = null;
    protected DocumentBuilder domBuilder = null;

    public CSVtoXML() {
        try {
            domFactory = DocumentBuilderFactory.newInstance();
            domBuilder = domFactory.newDocumentBuilder();
        } catch (FactoryConfigurationError | Exception exp) {
            System.err.println(exp.toString());
        }

    }

    public void convert(String csvFileName1, String csvFileName2, String outFileName) throws IOException {
        Document newDoc = domBuilder.newDocument();
        // Root element
        Element rootElement = newDoc.createElement("tree");
        newDoc.appendChild(rootElement);

        Map<Integer, Element> elemMap = new HashMap<>();

        BufferedReader csvReader;
        csvReader = new BufferedReader(new FileReader(csvFileName1));

        int line = 1;

        csvReader.readLine();

        String text = csvReader.readLine();

        StringTokenizer st = new StringTokenizer(text, ",", false);
        String[] rowValues = new String[st.countTokens()];

        for(int i = 0; i < 2; i++){
            String next = st.nextToken();
            rowValues[i] = next;
        }

        Element node = newDoc.createElement("node");
        node.setAttribute("id", rowValues[0]);
        node.setAttribute("name",rowValues[1]);
        node.setAttribute("profondeur", "0");
        node.setAttribute("largeur","0");

        rootElement.appendChild(node);

        elemMap.put(Integer.parseInt(rowValues[0]), node);

        while ((text = csvReader.readLine()) != null) {

            st = new StringTokenizer(text, ",", false);
            rowValues = new String[st.countTokens()];

            for(int i = 0; i < 2; i++){
                String next = st.nextToken();
                rowValues[i] = next;
            }

            if (line != 0) {
                node = newDoc.createElement("node");
                node.setAttribute("id", rowValues[0]);
                node.setAttribute("name",rowValues[1]);

                elemMap.put(Integer.parseInt(rowValues[0]), node);
            }
            line++;
        }

        csvReader = new BufferedReader(new FileReader(csvFileName2));
        line = 0;
        int parentID;
        int childID=0;

        int tempID = 0;
        int compteurlargeur = 0;

        
        while ((text = csvReader.readLine()) != null) {

            st = new StringTokenizer(text, ",", false);
            rowValues = new String[st.countTokens()];

            for(int i = 0; i < 2; i++){
                String next = st.nextToken();
                rowValues[i] = next;
            }
            if(line==1){
                parentID = Integer.parseInt(rowValues[0]);
                childID = Integer.parseInt(rowValues[1]);
                tempID = childID;
                elemMap.get(parentID).appendChild(elemMap.get(childID));
                elemMap.get(childID).setAttribute("profondeur", String.valueOf(1+Integer.parseInt(elemMap.get(parentID).getAttribute("profondeur"))));
                elemMap.get(parentID).setAttribute("largeur", String.valueOf(0));

            }
            else if (line != 0) {
                parentID = Integer.parseInt(rowValues[0]);
                childID = Integer.parseInt(rowValues[1]);
                elemMap.get(parentID).appendChild(elemMap.get(childID));
                elemMap.get(childID).setAttribute("profondeur", String.valueOf(1+Integer.parseInt(elemMap.get(parentID).getAttribute("profondeur"))));

                if(parentID != tempID){
                    elemMap.get(tempID).setAttribute("largeur", String.valueOf(1+compteurlargeur));
                    compteurlargeur ++;
                }
                else{
                    elemMap.get(tempID).setAttribute("largeur", String.valueOf(0));
                }
                tempID = childID;
            }

            line++;
        }
        elemMap.get(childID).setAttribute("largeur", String.valueOf(1+compteurlargeur));



        try {

            TransformerFactory tranFactory = TransformerFactory.newInstance();
            Transformer aTransformer = tranFactory.newTransformer();
            aTransformer.setOutputProperty(OutputKeys.INDENT, "yes");
            aTransformer.setOutputProperty(OutputKeys.METHOD, "xml");
            aTransformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");

            Source src = new DOMSource(newDoc);
            Result result = new StreamResult(new File(outFileName));
            aTransformer.transform(src, result);

        } catch (Exception exp) {
            exp.printStackTrace();
        }
    }

    public static void main(String[] args) throws IOException {
        CSVtoXML csvToXML = new CSVtoXML();
        csvToXML.convert("projet-xml/treeoflife_nodes.csv", "projet-xml/treeoflife_links.csv","projet-xml/result.xml");
        csvToXML.convert("projet-xml/node_sujet_exemple.csv", "projet-xml/link_sujet_exemple.csv","projet-xml/result2.xml");

    }
}
