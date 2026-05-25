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
	method esPlanta(){return true}	
	method crecer() { //regar
	  estado = maizAdulto
	}
	method validarCosechar(){
		if(not estado.esCosechable()){
			self.error("No esta listo para cosechar")
		}
	}
	method cosechar() {
	  self.validarCosechar() //solo se puede cosechar si el trigo esta en su estado completamente crecido
		game.removeVisual(self) //remueve el trigo cosechado del juego
	}
	method costo(){
		return 150
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
	method esPlanta(){return true}
	method sembrar(){
		game.addVisual(self)
	}
	
	method crecer() { //regar
	  if(estado < 3){  //si el trigo no esta completamente crecido, avanza a su siguiente estado
		estado = estado + 1
		}else {estado = 0} //si esta crecico, vuelve a su estado inicial 
	
	}
	method esCosechable() {
	return estado >= 2 //solo se puede cosechar si el trigo esta en su estado 2 o mas
	}
	method validarCosechar(){
		if(not self.esCosechable()){
			self.error("No esta listo para cosechar")
		}
	}
	method cosechar() {
	  self.validarCosechar() //solo se puede cosechar si el trigo esta en su estado completamente crecido
		game.removeVisual(self) //remueve el trigo cosechado del juego
	}

	method costo() {
	  return (estado-1) * 100 
	}

}



//tomaco
class Tomaco {
	var property position  
	var property image = "tomaco.png"
	
	method sembrar(){
		game.addVisual(self)
	}
	method esPlanta(){return true}
	method cosechar() {
	  game.removeVisual(self) //el tomaco siempre se puede cosechar
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
	  return 80
	}
}



