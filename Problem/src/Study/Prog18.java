/* 题目：两个乒乓球队进行比赛，各出三人。
 * 甲队为a,b,c三人，乙队为x,y,z三人。已抽签决定比赛名单。
 * 有人向队员打听比赛的名单。
 * a说他不和x比，c说他不和x,z比，请编程序找出三队赛手的名单。
 */

package Study;

public class Prog18 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		for(char i ='x';i<='z';i++){
		    for(char j ='x';j<='z';j++){
		        if(i!=j)//这里放一个判断，比赛队员不能重复比赛，判断写在外面又可以减少循环次数
		            for(char k = 'x';k<='z';k++){
		                if(i!=k&&j!=k)//同上，排除相同
		                    if(i!='x'&&k!='x'&&k!='z')//这里根据题意排除掉不符合的名单
		                        System.out.println("a和"+i+"\n"+"b和"+j+"\n"+"c和"+k+"\n");
		            }
		    }
		}
	
	}

}
