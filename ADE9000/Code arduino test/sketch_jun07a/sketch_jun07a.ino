// P04 S6E18 code arduino pour tester le ADE9000

// !!!!!  3.3 V tolerant !!!!
//le code est utilisé sur un arduino pro mini fonctionnant à 3.3 V
//Un arduino à 5V ne peut pas fonctionner même avec un diviseur de tension. Il y à un mismatch entre le Voh du ADE et le Vih du arduino alimenté à 5V.

#include <SPI.h>

//  Les constantes,variables et registres pour le ADE9000

#define PF_CMD 0x2168
#define THD_CMD 0x2178
#define ACCMODE_CMD 0x4928
#define RUN_CMD 0x4808
#define LAST_CMD  0x4AE8

#define ACCMODE_CMD_WRITE 0x4920
#define ACCMODE_CMD_READ 0x4928
#define VLEVEL_CMD  0x40F0
#define EP_CFG_CMD_WRITE  0x4B00
#define EP_CFG_READ 0x4B08
#define CONFIG0_CMD_READ  0x0608
#define CONFIG0_CMD_WRITE 0x0600

#define CONV 0.000000007450580597

float THD=0;  //en %
float PF=0;

//Les constantes et variables pour le arduino
#define chipSelect 6
#define TIMER_LECTURE 1000  //en ms
unsigned long last_millis=0; //permet de faire comme un timer qui ne bloque pas le code (voir fonction millis() d'arduino)
unsigned long temp=0;
unsigned short temp16=0;
unsigned short dsp_state=0;

//Les prototypes
void afficher_resultats();  //propre au arduino
unsigned long lecture_registre(short nb_bytes,unsigned short cmd_hdr); //dequoi de similaire pour notre application Atmel
void enable_dsp();  //enable le dsp (RUN=1)
void ecriture_registre(short nb_bytes,unsigned short cmd_hdr,unsigned long val);

void setup() {
  Serial.begin(9600); //pour la console avec arduino
  
  delay(500); //permet le setting des registres et du crystal (50ms aurait été plus précis mais moins safe) voir p.7 userguide
  
  SPI.begin();
  SPI.setDataMode (SPI_MODE3);  //voir datasheet ADE. Clock idle high et les bits sont lues sur les fronts montants
  pinMode(chipSelect,OUTPUT);
  
  //Configuration du ADE9000
  temp16=lecture_registre(2,ACCMODE_CMD_READ);  //config fréquence
  ecriture_registre(2,ACCMODE_CMD_WRITE,(temp16|0x0100));
  
  ecriture_registre(4,VLEVEL_CMD,0x00117514);//config VLEVEL nominal (1Vp)
  
  temp16=lecture_registre(2,EP_CFG_READ);//disable no load timer
  ecriture_registre(2,EP_CFG_CMD_WRITE,(temp16|0xE000));
  
  enable_dsp(); //dernière étape de la config du ADE9000

  temp=lecture_registre(2,LAST_CMD);  //2 étapes inutiles pour voir le fonctionnement au logic analyser
  temp=lecture_registre(2,RUN_CMD);

  
}

void loop() {

  delay(50);
  if (millis()>last_millis+TIMER_LECTURE) //vérification qui s'apparente à un Timer pour un environnement autre que Arduino
  {
    temp=lecture_registre(4,PF_CMD);
    PF=(float)temp * CONV;
    delay(1);
    temp=lecture_registre(4,THD_CMD);
    THD=(float)temp * 100 * CONV;
    delay(1);
    dsp_state=lecture_registre(2,RUN_CMD);
    delay(1);
    temp=lecture_registre(2,LAST_CMD);
    
    afficher_resultats();
    last_millis=millis();
  }
}
void enable_dsp()// (RUN=1)
{
  digitalWrite(chipSelect,LOW);
  
  SPI.transfer(0x48); //choisi RUN register pour write
  SPI.transfer(0x00);

  SPI.transfer(0x00);
  SPI.transfer(0x01); //enable DSP for mesurement
  digitalWrite(chipSelect,HIGH);
}
void ecriture_registre(short nb_bytes,unsigned short cmd_hdr,unsigned long val)
{
  // cmd_hdr: 16bits non signé incluant le bit3=0 pour le write
  //val: 32 bits où les 16 msb sont des don't care si nb_bytes
  byte msb=cmd_hdr>>8;
  byte lsb=(cmd_hdr<<8)>>8;
  
  byte byte1=0;
  byte byte2=0;
  byte byte3=0;
  byte byte4=0;

  if (nb_bytes==2)
  {
    byte1=val>>8;//isole les bytes et supprime les don't care qui seraient non-nul
    byte2=(val<<8)>>8;
  }
  else
  {
    byte1=val>>24;//isole les bytes et supprime les don't care qui seraient non-nul
    byte2=(val<<8)>>24;
    byte3=(val<<16)>>24;
    byte4=(val<<24)>>24;
  }
  digitalWrite(chipSelect,LOW);
  SPI.transfer(msb);  //le command header
  SPI.transfer(lsb);

  SPI.transfer(byte1);  //la valeur à écrire
  SPI.transfer(byte2);
  if (nb_bytes==4)
  {
    SPI.transfer(byte3);
    SPI.transfer(byte4);
  }
  digitalWrite(chipSelect,HIGH);
}
unsigned long lecture_registre(short nb_bytes,unsigned short cmd_hdr)  //faire quelque chose de similaire pour notre application
{
  // cmd_hdr: 16bits non signé incluant le bit3=1 pour le read
  
  unsigned long result=0;
  byte newbyte=0;
  byte msb=cmd_hdr>>8;
  byte lsb=(cmd_hdr<<8)>>8;
  
  digitalWrite(chipSelect,LOW);
  SPI.transfer(msb);
  SPI.transfer(lsb);
  result=SPI.transfer(0x00);  //écriture bidon pour lire
  nb_bytes--;

  while (nb_bytes>0)
  {
    result=result<<8; //decale tout d'un byte
    newbyte=SPI.transfer(0x00);
    result=result | newbyte;  //combine le vieux stock avec le newbyte
    nb_bytes--;
  }
  digitalWrite(chipSelect,HIGH);
  return result;
}

void afficher_resultats() //propre au arduino
{
  Serial.print('\n');
  Serial.print("Le taux de distorsion harmonique (%): ");
  Serial.print(THD,3);
  Serial.print('\n');
  Serial.print("Le facteur de puissance: ");
  Serial.print(PF,3);
  Serial.print('\n');
  
  Serial.print("DSP state : ");
  Serial.print(dsp_state);
  Serial.print('\n');
}