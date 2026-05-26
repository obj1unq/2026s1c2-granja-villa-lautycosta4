import wollok.game.*
import cultivos.*
object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	method esPlanta(){return false}
	method esMercado(){return false}
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
	method plantasEnPosicion(){
		return game.getObjectsIn(self.position())
		.filter{objeto => objeto.esPlanta()} //objetos en posicion sin contar al personaje
	}
	method lugarVacio() {		
		return self.plantasEnPosicion().isEmpty()
	}
	
	method regar() {
		const plantas = self.plantasEnPosicion()
	  		if(not plantas.isEmpty()){		
	  			plantas.forEach { planta =>	planta.crecer() } //riega todas las plantas en posicion
			}else{self.error("No hay planta para regar")}
	}
	
	const totalDineroVentas = [] 
	method totalDineroVentas(){return totalDineroVentas.sum()}
	const plantasCosechadas = []
	method plantasCosechadas(){return plantasCosechadas}

	method cosechar() {
		self.validarPlantasEnPosicion()		
		const planta = self.plantaEnPosicion()	  			
			planta.cosechar() //cosecha una sola planta en posicion
			plantasCosechadas.add(planta) //guarda la planta cosechada en el inventario del personaje
			totalDineroVentas.add(planta.costo())
	}

	method validarPlantasEnPosicion(){
		const planta=self.plantasEnPosicion()
		if(planta.isEmpty()){
			self.error("No hay planta para cosechar")
		}
	}
	method plantaEnPosicion(){
		return self.plantasEnPosicion().first()
	}
	method plantaYDinero(){
		game.say(self, "Tengo " + plantasCosechadas.size() + " plantas cosechadas y $" + totalDineroVentas.sum())
	}
	
	var property monedas= 0
	method vender() {
		self.validarMercadoLugar()
		const mercado = self.mercadoEnPosicion().first()
	  mercado.comprar(self)
      monedas = monedas + self.totalDineroVentas()
	  totalDineroVentas.clear() //reinicia el dinero acumulado por ventas
	  plantasCosechadas.clear() //reinicia el inventario de plantas cosechadas
	}
	method validarMercadoLugar(){
		if(self.lugarVacioMercado()){
			self.error("no hay mercado para vender aqui")
		}
	}
	

	method mercadoEnPosicion(){
		return game.getObjectsIn(self.position())
		.filter{objeto => objeto.esMercado()} //mercado en posicion sin contar al personaje ni plantas
	}	
	method lugarVacioMercado() {
	  return self.mercadoEnPosicion().isEmpty()
	}


	method instalarAspersor(){
		self.validarAspersor()
		const aspersor = new Aspersor(position = self.position()) 
		game.addVisual(aspersor)
		aspersor.activar()
	}

	method validarAspersor(){
		if(not self.lugarVacio()){
		self.error("No puedo instalar el aspersor aquí, ya hay algo plantado")
	}
	}
}
class Aspersor{
	var property position
	const property image = "aspersor.png"
	method regar(){
			self.posicionesAlrededor().forEach { posicion =>
			self.regarPosicion(posicion)
		}
	}
	method activar(){
		game.onTick(1000, "regar cada 1s", {self.regar()})
	}
	method regarPosicion(posicion) { 
		const plantas = game.getObjectsIn(posicion)
			.filter { objeto => objeto.esPlanta() }

		plantas.forEach { planta =>
			planta.crecer()
		}
	}
	method posicionesAlrededor() {
		return [
			game.at(position.x() + 1, position.y()),  //arriba
			game.at(position.x() - 1, position.y()), //abajo
			game.at(position.x() , position.y() + 1), //derecha
			game.at(position.x() , position.y() - 1) //izquierda
		]
	}
	method esMercado(){return false}
	method esPlanta(){return false}
}

class Mercado{
	var property position  
	const property image = "market.png"
	var property monedas = 0
	method text() = "Monedas:" + monedas
    method textColor() = paleta.verde()
	const mercaderia = []
	method puedeComprar(personaje) {
		return monedas >= personaje.totalDineroVentas()
	}
	method esMercado(){return true}
	method validarMercadoMonedas(personaje){		
		if(not self.puedeComprar(personaje)) {
		self.error("El mercado no tiene suficientes monedas")
	}
	}
	method comprar(personaje){
		self.validarMercadoMonedas(personaje)
		monedas= monedas - personaje.totalDineroVentas()
		mercaderia.add(personaje.plantasCosechadas())
	}
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