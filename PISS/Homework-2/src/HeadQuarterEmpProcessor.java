
import java.io.*;
import java.util.Date;

public class HeadQuarterEmpProcessor {

	public static void main(String[] args) {
		Employee emp = new Employee();
		emp.lName = "Valentin";
		emp.fName = "Kirilov";
		emp.salary = 123456789;
		emp.address = "Sofia, Bulgaria";
		emp.hireDate = new Date();
		
		FileOutputStream fOut = null;
		ObjectOutputStream oOut = null;
		
		try {
			fOut = new FileOutputStream("./NewEmployee.ser");
			oOut = new ObjectOutputStream(fOut);
			oOut.writeObject(emp); //serializing employee
		
			System.out.println("An employee is serialized into NewEmployee.ser");
		} catch(IOException e){
			e.printStackTrace();
		} finally {
			try {
				oOut.flush();
				oOut.close();
				fOut.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}

}
