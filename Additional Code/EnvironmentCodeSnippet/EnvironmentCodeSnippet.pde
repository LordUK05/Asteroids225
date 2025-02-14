void setup(){
 size(800,800);
 background(0);
}

boolean running = true;
int XPos = 250;
int YPos = -150;
int size = 0;
int lastSize = 0;
int counter = 0;
int[] positions = new int[33];
void draw(){
  rectMode(CENTER);
  while (running){
    counter += 1;
    lastSize = size;
    size = int(random(60,100));
    while(size % 2 == 1){
      size = int(random(60,100));
    }
    XPos = 200-(size/2);
    YPos += (0.5*lastSize)+(0.5*size);
    XPos = XPos+800;
    print(XPos+",");
    print(YPos+",");
    print(size+",");
    square(XPos,YPos,size);
    //text(XPos+" "+YPos+" "+size+" "+lastSize,XPos+200,YPos);
    if(counter>13){
     running = false; 
    }
    XPos = 200;
  }
 noLoop(); 
 exit();
}
