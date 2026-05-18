import personaje.*
import wollok.game.*

class Maiz{
	var property estado = maizBebe 
	var property position  
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_baby.png"
	}
	method sembrar(){

	}
	method cosechar() {
	  
	}
	method crecer() { //regar
	  
	}
	method costo() {
	  
	}

}
//maiz
object maizBebe {
  method esCosechable(){
	return false
  }
}
object maizAdulto {
  method esCosechable(){
	return true
  }
}


class Trigo {
	var property position  
  method image() {
	return "wheat_0.png"
  }
}
class Tomaco {
var property position 
  method image() {
	return "tomaco_baby.png"
  }
}



/*
class Cultivo {
	var property imagen = "" 
  method position() {
	return game.at(personaje.position().x(), personaje.position().y())
}
method image() {
  return imagen
}
}
*/
