class ElemWrapper
{

  PVector originalPosition = null;
  PVector actualPosition = null;
  Integer IDX;
  Integer xIDX, yIDX;
  Float elmW, elmH;
  float opacity = 150;
  float ellipseRadius = 1;
  PVector moveTo;
  boolean resting = true;
  int alIDX;

  public ElemWrapper(PVector originalPosition, Integer alIDX, Integer IDX, Integer xIDX, Integer yIDX, Float elmW, Float elmH)
  {
    this.originalPosition = originalPosition; 
    this.IDX = IDX; 
    this.xIDX = xIDX; 
    this.yIDX = yIDX; 
    this.elmW = elmW; 
    this.elmH = elmH; 
    this.actualPosition = originalPosition;
    this.moveTo = originalPosition;
    this.alIDX = alIDX;
  }

  public void _drawMe()
  {
    pushMatrix();
   
    translate(actualPosition.x, actualPosition.y);
    
    if(abs(this.moveTo.x- this.originalPosition.x) < 10 && abs(this.moveTo.y - this.originalPosition.y) < 10)
    {
         stroke(palettes[this.alIDX % palettes.length], opacity);
        ellipse(0, 0, ellipseRadius, ellipseRadius);
    }
    else
   {
        stroke(palettes[this.alIDX % palettes.length], opacity);
       
       //ellipse(0, 0, ellipseRadius*3, ellipseRadius*3);
        line(0, 0, this.moveTo.x - this.actualPosition.x, this.moveTo.y-this.actualPosition.y);
   }
   
 
   
    
    


    popMatrix();
  }

  public void _move(float _movevelocity)
  {

    float deltax =  _movevelocity *( this.moveTo.x - this.actualPosition.x ) + (-NOISE + random(2*NOISE));
    float deltay =  _movevelocity *( this.moveTo.y - this.actualPosition.y )  +  (-NOISE + random(2*NOISE));
    
    
    this.actualPosition = new PVector(  
      this.actualPosition.x + deltax, this.actualPosition.y + deltay    );

    if (abs(deltax) < 2 && abs(deltay)< 2)
    {
      this.moveTo = this.originalPosition;
    }
     

  }


  public void moveToVicino(int direzione)
  {
    resting = false;
    int  idxXTarget= 0, idxYTarget= 0;
    if (direzione == 1) { 
      idxXTarget = this.xIDX+NUM_VICINI_SPOSTAMENTO;  
      idxYTarget = this.yIDX;
    } else if (direzione == 2) {
      idxXTarget = this.xIDX;  
      idxYTarget = this.yIDX+NUM_VICINI_SPOSTAMENTO;
    } else if (direzione == 3) { 
      idxXTarget = this.xIDX-NUM_VICINI_SPOSTAMENTO;  
      idxYTarget = this.yIDX;
    } else if (direzione == 4) {  
      idxXTarget = this.xIDX;  
      idxYTarget = this.yIDX-NUM_VICINI_SPOSTAMENTO;
    }

    try {
      this.actualPosition = this.originalPosition;
      this.moveTo = elms.get(this.alIDX)[idxYTarget][idxXTarget].originalPosition;
    } 
    catch(Exception ex) {
    }
  }
}
