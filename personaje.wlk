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
	
	const totalDineroVentas = [] 
	const plantasCosechadas = []
	
	method cosechar() {
		self.validarPlantasEnPosicion()		
		const planta = self.plantaEnPosicion()	  			
			planta.cosechar() //cosecha una sola planta en posicion
			plantasCosechadas.add(planta) //guarda la planta cosechada en el inventario del personaje
			totalDineroVentas.add(planta.costo())
	}

	method validarPlantasEnPosicion(){
		const planta=self.objetosEnPosicion()
		if(planta.isEmpty()){
			self.error("No hay planta para cosechar")
		}
	}
	method plantaEnPosicion(){
		return self.objetosEnPosicion().first()
	}
	method plantaYDinero(){
		game.say(self, "Tengo " + plantasCosechadas.size() + " plantas cosechadas y $" + totalDineroVentas.sum())
	}
	
	var property monedas= 0
	method vender() {
	  monedas = monedas + totalDineroVentas.sum()
	  totalDineroVentas.clear() //reinicia el dinero acumulado por ventas
	  plantasCosechadas.clear() //reinicia el inventario de plantas cosechadas
	}
	method instalarAspersor(){
		self.validarAspersor()
		game.addVisual(aspersor)
	}
	method validarAspersor(){
		if(not self.lugarVacio()){
		self.error("No puedo instalar el aspersor aquí, ya hay algo plantado")
	}
	}
}
object aspersor{
	var property position = personaje.position()
	const property image = "aspersor.png"
	
}





















//monedas
object barraMonedas {

    method position() = game.at(1,1)
	method textColor() {return paleta.amarillo()}
    method text() {
        return "Monedas: " + personaje.monedas()	
    }
}
object paleta {
    const property verde = "00FF00FF"
    const property amarillo = "FFFF00FF"
    const property rojo = "FF0000FF"
}