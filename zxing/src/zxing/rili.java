package zxing;

import java.util.Scanner;

public class rili {
	public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        System.out.println("������һ����ݣ�");
        int year = s.nextInt();
        System.out.println("������һ���·ݣ�");
        int month =s.nextInt();
        int yearSum = 0;
        int monthSum = 0;
        for (int i = 1900; i < year; i++) {
            yearSum += 365;
            if (i % 4 == 0 && i % 100 != 0 || i % 400 == 0) {
                yearSum += 1;
            }
        }
        System.out.println(yearSum);
        for (int i = 1; i < month; i++) {
            switch (i) {
                case 4:
                case 6:
                case 9:
                case 11:
                    monthSum += 30;
                    break;
                case 2:
                    monthSum += 28;
                    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
                        monthSum += 1;
                    }
                    break;
                default:
                    monthSum += 31;
                    break;

            }
        }
        System.out.println(monthSum);
        //����ո����
        int blank = 0;
        blank = ((monthSum+yearSum)%7+1)%7;
        int days = 0;
        switch (month){
            case 4:
            case 6:
            case 9:
            case 11:
                days = 30;
                break;
            case 2:
                days = 28;
                if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
                    days += 1;
                }
                break;
            default:
                days = 31;
        }
        System.out.println("�������"+days+"��");

        System.out.print("��\tһ\t��\t��\t��\t��\t��");
        System.out.println();
        for (int i =1;i<=blank;i++){
            System.out.print(" \t");
        }
        for (int i = 1;i<=days;i++){
            if (i<10) {
                System.out.print(" " + i + "\t");
            }else
                System.out.print(i + "\t");
            if ((blank+i)%7 ==0){
                System.out.println();
            }
        }

    }
}
