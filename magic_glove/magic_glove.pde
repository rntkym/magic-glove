import processing.serial.*;
Serial microbit;

float[][] array = new float[300][7];
int order = 0;
float red, green, blue, opacity, x, y, size, attribute, magic1, magic2;

void setup() {
  surface.setSize(1500, 900); 
  fullScreen();
  String portName = Serial.list()[1];
  println(portName);
  microbit = new Serial(this, portName, 115200);
  microbit.clear();
  microbit.bufferUntil(10);
}

void draw() {
  int volume = 1;
  background(0);
  
  if(magic1 == 1 || magic2 == 1){
    volume = 200;
    order = 0;
  }
  
  for(int i = 0; i < volume; i ++){
    opacity = random(200);
    //green
    if(attribute == 1){
      red = random(50);
      green = random(100, 150);
      blue = random(150);
    }
    //brown
    else if(attribute == 2){
      red = random(100, 150);
      green = random(50, 100);
      blue = random(50);   
    }
    //blue
    else if(attribute == 3){
      red = random(50);
      green = random(255);
      blue = random(200, 255);
    }
    //red
    else if(attribute == 4){
      red = random(200, 255);
      green = random(150);
      blue = random(50);
    }
    //yellow
    else if(attribute == 5){
      red = random(200, 255);
      green = random(150, 250);
      blue = random(50);
    }
    //purple
    else{
      red = random(150);
      green = random(50);
      blue = random(150);
    }
    
    if (magic1 == 1){
      x = random(width);
      y = height / 2 + random(-50, 50);
      size = random(100);
    }
    else if(magic2 == 1){
      x = random(width);
      y = random(height);
      size = random(200);
    }
    else{
      x = x + random(-20, 20);
      y = y + random(-20, 20);
      size = random(50);
    }
 
    float[] args = {red, green, blue, opacity, x, y, size};
    array[order] = args;
    
    order += 1;
    if(order == 300){
      order = 0;
    }
  }

  for(int i = 0; i < 300; i ++){
    fill(array[i][0], array[i][1], array[i][2], array[i][3]);
    noStroke();
    ellipse(array[i][4], array[i][5], array[i][6], array[i][6]);
    array[i][6] -= 1;
    if(array[i][6] < 0){
      array[i][6] = 0;
    }
  }
}

void serialEvent(Serial microbit) {
  String str = microbit.readStringUntil('\n');
  String[] info = str.split(",");
  println(str);
  if(info.length == 5){
    x = float(info[0]);
    y = float(info[1]);
    attribute = float(info[2]);
    magic1 = float(info[3]);
    magic2 = float(info[4]);
  }
}
