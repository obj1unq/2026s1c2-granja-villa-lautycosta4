import wollok.game.*
import cultivos.*
object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method mover(direccion) {
		const nuevaPosition = direccion.siguiente(position)
		self.position() == nuevaPosition
	}
	method sembrar(planta) {
	  if(not self.lugarVacio()){
		game.say(self, "No puedo sembrar aquí, ya hay algo plantado")
	  }else {		
	 planta.sembrar() }
	}
	method objetosEnPosicion(){
		return game.getObjectsIn(self.position())
		.filter{objeto => objeto != self} //objetos en posicion sin contar al personaje
	}
	method lugarVacio() {		
		return self.objetosEnPosicion().isEmpty()
	}
	
	method regar() {
		const planta = self.objetosEnPosicion()
	  		if(not planta.isEmpty()){		
	  			planta.first().crecer() //riega una sola planta en posicion
			}else{self.error("No hay planta para regar")}
	}
	
	const plantasCosechadas = []
	method cosechar() {
		const planta = self.objetosEnPosicion()
	  		if(not planta.isEmpty()){		
	  			planta.first().cosechar() //cosecha una sola planta en posicion
				plantasCosechadas.add(planta.first()) //agrega la planta cosechada a la lista de cosechas
			}else{self.error("No hay planta para cosechar")}
	}
	method vender() {
	  
	}
	
}