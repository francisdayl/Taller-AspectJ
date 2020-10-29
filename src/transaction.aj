import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.time.LocalDateTime;

public aspect transaction {
	LocalDateTime locaDate = LocalDateTime.now();
	int hours  = locaDate.getHour();
	int minutes = locaDate.getMinute();
	int seconds = locaDate.getSecond();
	
    File file = new File("log.txt");
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    
    pointcut retiro() : call(* money*(..) );
    after() : retiro() {
  	
    	try{
    		FileWriter writer=new FileWriter("log.txt",true);
    		BufferedWriter bw=new BufferedWriter(writer);
    		bw.write("TEEEEXTOOOO");
    		bw.newLine();
    		bw.close();
    	}
    	catch(FileNotFoundException e){
    		FileReader reader = new FileReader("log.txt");
    		BufferedReader br= new BufferedReader(reader);
    		String linea;
    		String lt;
    		while((lt=br.readLine())!=null){
    			linea.concat(lt);
    		}
    		reader.close();

    		FileWriter writer=new FileWriter("log.txt",true);
    		BufferedWriter bw=new BufferedWriter(writer);
    		bw.write(linea);
    		bw.newLine();
    		bw.write(thisJoinPointStaticPart.getSignature().getName()+" a las: " + hours  + ":"+ minutes +":"+seconds);
    		bw.close();
    	}except(Exception e){
    		System.out.println("No se pudo ingresar el texto");
    	}
    	System.out.println(thisJoinPointStaticPart.getSignature().getName()+" a las: " + hours  + ":"+ minutes +":"+seconds);
    }
}