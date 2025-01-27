
void mouseClicked(){
 if (isTitle){
   if (mouseX>200 && mouseX<600 && mouseY>400 && mouseY<500){
     isTitle = false;
   }
 }
}

void mouseDragged(){
  if (mouseX>200 && mouseX<600 && mouseY>400 && mouseY<500){
    isTitle = false;
  }
}

void keyPressed(){
  
}
