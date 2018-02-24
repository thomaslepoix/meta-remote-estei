#include <QCoreApplication>
#include <QThread>
#include <iostream>
#include <fstream>
#include <QFile>
#include <MyTcpSocket.h>
#include <QDebug>

#include <QFile>
#include <QDebug>

void read_ip()
{
    QFile inputFile("/etc/remote_ip.conf");
    if (inputFile.open(QIODevice::ReadOnly))
    {
        MyTcpSocket::set_ip(inputFile.readAll());
        inputFile.close();
    }
}

//QString directory="/home/qt/test_project/";
QString directory="/sys/class/gpio/";
QString gpio_path[7];
unsigned char key_status=0;


void init_gpio(void);
void showParam(void);
void thread_gpio(void);
void thread_message(void);

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    init_gpio();
    //read_ip();
    MyTcpSocket::sendData("INIT");

    while(1)
    {
        thread_gpio();

        thread_message();
    }

    return a.exec();
}

void thread_gpio(void) {
    char a=0;


    for(int i=0;i<7;++i){
        QFile myfile(directory+gpio_path[i]);

        if (myfile.open(QIODevice::ReadOnly | QIODevice::Text))
        {
            QString str = myfile.readAll();

            if(str==QString("0\n"))
            {
                a+=(0x01<<i);

            }

            myfile.close();

        }
    }
    if(a!=key_status){
        key_status=a;
    }
}

void thread_message(void){
    if(key_status&(0x01<<6)){
        MyTcpSocket::sendData("STOP");
        system("poweroff");           // revoir
    }else{
        if(key_status&(0x01<<4)){

            MyTcpSocket::sendData("RD");
        }else if(key_status&(0x01<<5)){

            MyTcpSocket::sendData("RG");
        }else{
            unsigned char a=key_status&0x0f;
            switch(a){

            case 1:

                MyTcpSocket::sendData("H");
                break;
            case 5:

                MyTcpSocket::sendData("HD");
                break;
            case 9:

                MyTcpSocket::sendData("HG");
                break;
            case 2:

                MyTcpSocket::sendData("B");
                break;
            case 6:

                MyTcpSocket::sendData("BD");
                break;
            case 10:

                MyTcpSocket::sendData("BG");
                break;
            case 4:

                MyTcpSocket::sendData("D");
                break;
            case 8:

                MyTcpSocket::sendData("G");
                break;
            case 3:

                MyTcpSocket::sendData("STOP");
            case 12:

                MyTcpSocket::sendData("INIT");
            default:

                break;
            }
        }
    }

}

void init_gpio(void){
    gpio_path[0]="gpio22/value";    //  haut
    gpio_path[1]="gpio17/value";    //  bas
    gpio_path[2]="gpio4/value";     //  droite
    gpio_path[3]="gpio23/value";    //  gauche
    gpio_path[4]="gpio3/value";     //  rot droite
    gpio_path[5]="gpio27/value";    //  rot gauche
    gpio_path[6]="gpio2/value";     //  power
}


