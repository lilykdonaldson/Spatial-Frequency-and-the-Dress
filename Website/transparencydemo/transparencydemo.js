var SurSize = 250;
var DiskSize = 125;
var TopX = 100;
var TopY = 100;
var s1 = "Back"

function setup() {
  createCanvas(900, 600);
  imageMode(CENTER);
  ellipseMode(CENTER)
  
  
  rBack1 = createSlider(0, 255, 0);
  rBack1.position(TopX, TopY+SurSize+40+20);
  gBack1 = createSlider(0, 255, 0);
  gBack1.position(TopX, TopY+SurSize+40+50);
  bBack1 = createSlider(0, 255, 0);
  bBack1.position(TopX, TopY+SurSize+40+80);
  
  rBack2 = createSlider(0, 255, 255);
  rBack2.position(TopX+SurSize+50, TopY+SurSize+40+20);
  gBack2 = createSlider(0, 255, 255);
  gBack2.position(TopX+SurSize+50, TopY+SurSize+40+50);
  bBack2 = createSlider(0, 255, 255);
  bBack2.position(TopX+SurSize+50, TopY+SurSize+40+80);
  
  
  rCent = createSlider(0, 255, 128);
  rCent.position(TopX+2*SurSize+2*50, TopY+SurSize+40+20);
  gCent = createSlider(0, 255, 128);
  gCent.position(TopX+2*SurSize+2*50, TopY+SurSize+40+50);
  bCent = createSlider(0, 255, 128);
  bCent.position(TopX+2*SurSize+2*50, TopY+SurSize+40+80);
  
  rOver = createSlider(0, 255, 128);
  rOver.position(TopX+2*SurSize+2*50, TopY+20);
  //rOver.size(30);
  gOver = createSlider(0, 255, 128);
  gOver.position(TopX+2*SurSize+2*50, TopY+50);
  bOver = createSlider(0, 255, 128);
  bOver.position(TopX+2*SurSize+2*50, TopY+80);
  aOver = createSlider(0, 255, 0);
  aOver.position(TopX+2*SurSize+2*50, TopY+110);
  
}

function draw() {
  background(128,130,149,255)
  WriteText();
  noStroke();
  fill(rBack1.value(), gBack1.value(), bBack1.value(),255);
  rect(TopX, 100, SurSize, SurSize)
  fill(rBack2.value(), gBack2.value(), bBack2.value(),255);
  rect(TopX+SurSize+50, 100, SurSize, SurSize)
  
  fill(rCent.value(), gCent.value(), bCent.value(),255);
  ellipse(TopX+SurSize/2, 100+SurSize/2, DiskSize, DiskSize)
  ellipse(TopX+SurSize+50+SurSize/2, 100+SurSize/2, DiskSize, DiskSize)
  
  
  fill(rOver.value(), gOver.value(), bOver.value(),aOver.value());
  rect(TopX, 100, SurSize, SurSize)
  rect(TopX+SurSize+50, 100, SurSize, SurSize)
  
  print(aOver.value())
  
}

function WriteText() {
  textSize(20);
  fill(20,50,70,255);
  text("Background", TopX+10, TopY+SurSize+45);
  text("Background", TopX+SurSize+50+10, TopY+SurSize+45);
  text("Centers", TopX+2*SurSize+2*50+10, TopY+SurSize+45);
  text("Overlay", TopX+2*SurSize+2*50+10, TopY+5);
  var s =("A = "+aOver.value()+" "+rOver.value());
  text(s, TopX+2*SurSize+2*50+10, TopY-50);
}