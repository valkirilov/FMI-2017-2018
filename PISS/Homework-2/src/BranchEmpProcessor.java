import java.io.*;

public class BranchEmpProcessor {

	public static void main(String[] args) {
		FileInputStream fIn = null;
		ObjectInputStream oIn  =null;
		
		try {
			fIn = new FileInputStream("./NewEmployee.ser");
			oIn = new ObjectInputStream(fIn);

			//de-serializing employee
			Employee emp = (Employee) oIn.readObject();
			System.out.println("Deserialized " + emp.fName + " " + emp.lName + " from NewEmployee.ser ");
			System.out.println("Deserialized salary value is " + emp.salary);
		} catch(IOException e){
			e.printStackTrace();
		} catch(ClassNotFoundException e){
			e.printStackTrace();
		} finally{
			try {
				oIn.close();
				fIn.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}

}
