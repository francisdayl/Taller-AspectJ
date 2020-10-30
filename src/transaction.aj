import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
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
    	try {
    		FileWriter wr = new FileWriter("log.txt",true);
    		BufferedWriter bw = new BufferedWriter(wr);
    		
    		bw.write(thisJoinPointStaticPart.getSignature().getName()+" a las: " + hours  + ":"+ minutes +":"+seconds);
    		bw.newLine();
    		
    		bw.close();
    	}catch(IOException e) {
    		System.out.println("No se pudo agregar el registro");
    	}
    	System.out.println("****Registro Exitoso****");
    	}
    }
