/* ��Ŀ������ƹ����ӽ��б������������ˡ�
 * �׶�Ϊa,b,c���ˣ��Ҷ�Ϊx,y,z���ˡ��ѳ�ǩ��������������
 * �������Ա����������������
 * a˵������x�ȣ�c˵������x,z�ȣ��������ҳ��������ֵ�������
 */

package Study;

public class Prog18 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		for(char i ='x';i<='z';i++){
		    for(char j ='x';j<='z';j++){
		        if(i!=j)//�����һ���жϣ�������Ա�����ظ��������ж�д�������ֿ��Լ���ѭ������
		            for(char k = 'x';k<='z';k++){
		                if(i!=k&&j!=k)//ͬ�ϣ��ų���ͬ
		                    if(i!='x'&&k!='x'&&k!='z')//������������ų��������ϵ�����
		                        System.out.println("a��"+i+"\n"+"b��"+j+"\n"+"c��"+k+"\n");
		            }
		    }
		}
	
	}

}
