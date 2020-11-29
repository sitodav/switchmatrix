

color[] palettes = new color[]{#ef476f, #ffd166, #06d6a0, #118ab2, #073b4c};
int N_ELMS_HOR = 10;
int N_ELMS_VER = 10; 
int N_ELMS_HOR_TOT = 2;
int N_ELMS_VER_TOT = 2; 
ArrayList<ElemWrapper[][]> elms;
ArrayList<PVector> starts;
int TEMP = 1;
int TEMP2 = 1;
int NUM_VICINI_SPOSTAMENTO = 1; //PAR HERE
int NOISE = 1;
int background = 255;
int foreground = 0;


void init()
{


  float elmw = ((width -10)/N_ELMS_HOR_TOT) / (float)N_ELMS_HOR  ;
  float elmh = ((height -10)/N_ELMS_VER_TOT)/ (float)N_ELMS_VER ;
  elms = new ArrayList<ElemWrapper[][]>();
  elms.add( new ElemWrapper[N_ELMS_VER][N_ELMS_HOR]);
  elms.add( new ElemWrapper[N_ELMS_VER][N_ELMS_HOR]);
  elms.add( new ElemWrapper[N_ELMS_VER][N_ELMS_HOR]);
  elms.add( new ElemWrapper[N_ELMS_VER][N_ELMS_HOR]);

  for (int i = 0; i< starts.size(); i++)
  {
    int ys = i/2;
    int xs = i%2;

    ElemWrapper[][] elmT = elms.get(i);
    PVector start = starts.get(i);
    for (int y = 0; y< N_ELMS_VER; y++)
    {
      for (int x = 0; x < N_ELMS_HOR; x++)
      {
        elmT[y][x] = new ElemWrapper( new PVector(start.x + x * elmh, start.y + y * elmw), i, y * N_ELMS_HOR + x, x, y, elmw, elmh  );
      }
    }
  }
}
void setup()
{

  size(450, 450);
  background(255);

  starts = new ArrayList<PVector>();
  starts.add(new PVector(10, 10));
  starts.add(new PVector(width/2 + 10, 10));
  starts.add(new PVector(10, 10+height/2));
  starts.add(new PVector(10+ width/2, 10+ height/2));


  init();
}






void keyPressed()
{
  int direzioneSpost = 0;
  switch(keyCode)
  {
  case UP : 
    NUM_VICINI_SPOSTAMENTO +=2;
    ;   
    return;
  case DOWN: 
    NUM_VICINI_SPOSTAMENTO -=2; 
    NUM_VICINI_SPOSTAMENTO = max(1, NUM_VICINI_SPOSTAMENTO);
    return;
  case ENTER : 
    TEMP++; 
    break;
  case TAB: 
    TEMP--; 
    break;
  case SHIFT : 
    TEMP2++; 
    break;
  case LEFT: 
    TEMP2--; 
    break;
  }
  switch(key)
  {
  case 'q' : 
    NOISE++; 
    break;
  case 'a' : 
    NOISE--; 
    break;
  case 'y' : 
    ArrayList<PVector> _starts = new ArrayList<PVector>();
    _starts.add(new PVector(starts.get(0).x, (starts.get(0).y-(height/8))));
    _starts.add(new PVector(starts.get(1).x, (starts.get(1).y-(height/8))));
    _starts.add(new PVector(starts.get(2).x, (starts.get(2).y+(height/8))));
    _starts.add(new PVector(starts.get(3).x, (starts.get(3).y+(height/8))));
    starts = _starts;
    init();
   return;
  case 'h' : 
     _starts = new ArrayList<PVector>();
    _starts.add(new PVector(starts.get(0).x, (starts.get(0).y+(height/8))));
    _starts.add(new PVector(starts.get(1).x, (starts.get(1).y+(height/8))));
    _starts.add(new PVector(starts.get(2).x, (starts.get(2).y-(height/8))));
    _starts.add(new PVector(starts.get(3).x, (starts.get(3).y-(height/8))));
    starts = _starts;
    init();
   return;
  case 'g' : 
     _starts = new ArrayList<PVector>();
    _starts.add(new PVector(starts.get(0).x-(width/8), (starts.get(0).y))); 
    _starts.add(new PVector(starts.get(1).x+(width/8), (starts.get(1).y)));  
    _starts.add(new PVector(starts.get(2).x-(width/8), (starts.get(2).y))); 
    _starts.add(new PVector(starts.get(3).x+(width/8), (starts.get(3).y))); 
    starts = _starts;
    init();
   return;
  case 'j' : 
     _starts = new ArrayList<PVector>();
    _starts.add(new PVector(starts.get(0).x+(width/8), (starts.get(0).y))); 
    _starts.add(new PVector(starts.get(1).x-(width/8), (starts.get(1).y)));  
    _starts.add(new PVector(starts.get(2).x+(width/8), (starts.get(2).y))); 
    _starts.add(new PVector(starts.get(3).x-(width/8), (starts.get(3).y))); 
    starts = _starts;
    init();
   return;
  }



  for (int i = 0; i< starts.size(); i++)
  {

    ElemWrapper[][] elmT = elms.get(i); 
    for (int y = 0; y< N_ELMS_VER; y++)
    {
      for (int x = 0; x < N_ELMS_HOR; x++)
      {
        if (i == 0)
        {   
          elmT[y][x].moveToVicino( 1+ (  abs(TEMP*x- TEMP2*y)  )%4 );
        } else if (i == 1)
        {   
          elmT[y][x].moveToVicino( 1+ (  abs(TEMP*TEMP*x- TEMP2*y)  )%4 );
        } else if (i == 2)
        {   
          elmT[y][x].moveToVicino( 1+ (  abs(TEMP*x- TEMP*TEMP2*y)  )%4 );
        } else if (i == 3)
        {   
          elmT[y][x].moveToVicino( 1+ (  abs( x-  y)  )%4 );
        }
      }
    }
  }
}

void draw()
{

  //background(255);
  fill(background,  5);
  rect(0, 0, width, height);



  for (int i = 0; i< starts.size(); i++)
  {

    ElemWrapper[][] elmT = elms.get(i); 
    for (int y = 0; y< N_ELMS_VER; y++)
    {
      for (int x = 0; x < N_ELMS_HOR; x++)
      {

        elmT[y][x]._move(  0.2-map(  abs(y-N_ELMS_VER/2) + abs(x-N_ELMS_HOR/2), 0, N_ELMS_HOR, 0.01, 0.2)  ); //PAR HERE 
        float t = 0.2-map(  abs(y-N_ELMS_VER/2) + abs(x-N_ELMS_HOR/2), 0, N_ELMS_HOR, 0.01, 0.2);
        // float op = map(t, 0, 0.2, 0, 200);
        // elmT[y][x].opacity = op;
        elmT[y][x]._drawMe();
      }
    }
  }
}
