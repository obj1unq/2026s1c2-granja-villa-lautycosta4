import personaje.*
import wollok.game.*
import direcciones.*
// maiz
class Maiz{
	var property estado = maizBebe 
	var property position  
	method image(){
		return estado.image() //su imagen depende del estado de la planta
	}
	method sembrar(){
		game.addVisual(self)
	}
	
	method crecer() { //regar
	  estado = maizAdulto
	}
	method costo() {
	  
	}
method cosechar() {
	  
	}
}
//maiz crecimiento
object maizBebe {
  method esCosechable(){
	return false
  }
  method image(){
	return "corn_baby.png"
  }
}
object maizAdulto {
  method esCosechable(){
	return true
  }
  method image() {
	return "corn_adult.png"
  }
}

//trigo
class Trigo {
	var property estado = 0 //grados de evolucion del trigo
	var property position  
	method image(){
		return "wheat_" + estado + ".png" //muestra imagen del trigo en su evolucion/estado actual
	}

	method sembrar(){
		game.addVisual(self)
	}
	
	method crecer() { //regar
	  if(estado < 3){  //si el trigo no esta completamente crecido, avanza a su siguiente estado
		estado = estado + 1
		}else {estado = 0} //si esta crecico, vuelve a su estado inicial 
	
	}

	method costo() {
	  
	}
method cosechar() {
	  
	}
}



//tomaco
class Tomaco {
	var property position  
	var property image = "tomaco.png"
	
	method sembrar(){
		game.addVisual(self)
	}
	method cosechar() {
	  
	}
	method crecer() { //regar
	  if(not self.estaEnBordeArriba()){
		position = self.subir()
	  }else {position = self.bajarHastaBorde() }
	}
	method subir(){
		return game.at(self.position().x(), self.position().y() + 1)
	}
	method bajarHastaBorde(){
		return game.at(self.position().x(),0)
	}
	method estaEnBordeArriba(){
		return self.position().y() == game.height()-1
	} 
	method costo() {
	  
	}
}



