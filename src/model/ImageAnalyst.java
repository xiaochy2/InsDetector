package model;
import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ImageAnalyst {
	
	String response;
	String[] matchedItems;
	int matchedItemsNum = 0;
	
	public String[] analyseImages(String[][] imagesURL) throws IOException {
		int length = imagesURL.length;
		this.matchedItems = new String[15*length];
		for (int i = 0; i<length; i++) {
			

			String[] result = analyseImage(imagesURL[i][0]);
			if(result.length==0||result[0]==null)
				break;
			//System.out.print("Scanning pics No." + i + ", result: " );
			for (int j = 0; j<result.length; j++) {
				if(result[j]==null)
					break;
				matchedItems[matchedItemsNum] = result[j];
				//System.out.print(matchedItems[matchedItemsNum]+" ");
				matchedItemsNum++;
			}
			//System.out.println();

		}
		return matchedItems;
	}
	
	public String[] analyseImage(String imageURL) throws IOException{
		String apiLink = "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyCVMZ0va0CqqesnJmJcXkMVt0gb4ZCkLkc";
		String json;
		json = "{\n\"requests\":[\n{\n\"image\":{\n\"source\":{\n"
				+ "\"imageUri\":\""+imageURL+"\"\n}\n},\n"
				+ "\"features\":[\n{\n\"type\":\"LABEL_DETECTION\"\n}\n]\n}\n]\n}";
		Connection con = Jsoup.connect(apiLink)
				.header("Content-Type", "application/json")
				.ignoreContentType(true)
				.requestBody(json);
		response = con.post().body().toString();
		//response = Jsoup.connect(apiLink).ignoreContentType(true).execute().body();
		
		response = response.replace("<body>\n ", "");
		response = response.replace("</body>", "");

		JSONObject jsonResponse = new JSONObject(response.toString());

		ImageAnalysedJsonParser ajp = new ImageAnalysedJsonParser();

		return ajp.parseAnalysedJson(jsonResponse);
	}
}
