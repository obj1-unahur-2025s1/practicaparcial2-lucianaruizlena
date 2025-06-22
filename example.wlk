class Personaje {
  const property fuerza
  var property rol //Cada personaje tiene un único rol, pero, si se aburren, pueden cambiarlo por otro haciendo el trámite correspondiente.
  const property inteligencia

  method potencialOfensivo() = (fuerza * 10) + rol.extra()
  method esInteligente()

  method esGroso() = self.esInteligente() || rol.esGroso()
}

class Orco inherits Personaje {

  override method potencialOfensivo(){
    return if(rol == brujo){
    super() * 1.10 
    } else super()
  }
  override method esInteligente() = false
}

class Humano inherits Personaje {
  override method esInteligente() = inteligencia > 50
}

object guerrero {
  method extra() = 100
  method esGroso(unPersonaje) = unPersonaje.fuerza() > 50
}

class Cazador {
  const mascota

  method extra() = mascota.potencialOfensivo()
  method esGroso(unPersonaje) = mascota.esLongeva()
}

object brujo {
  method extra() = 0
  method esGroso(unPersonaje) = true 
}

class Mascota {
  const fuerza
  var edad
  const tieneGarras

  method potencialOfensivo(){
    if(not tieneGarras){
      return fuerza
      } else fuerza * 2
    }

  method esLongeva() = edad > 10 
}

/*---------------------------------------------------------------*/

class Localidad {
  var habitantes

  method poderDefensivo() = habitantes.poderOfensivo()
  method serOcupada(unEjercito) 
}

class Aldea inherits Localidad {
  const maximaTropa

  method initialize() {
      if(maximaTropa<10) {
          self.error("La poblacion debe ser mayor a 10")
      }
  }
  override method serOcupada(unEjercito) {
      if(maximaTropa < unEjercito.tamaño()) {
          habitantes = new Ejercito(tropa=unEjercito.losMasPorderosos())
          unEjercito.quitarLosMasFuertes()
      }
      else {habitantes = unEjercito}
  }
}

class Ciudad inherits Localidad {
    override method poderDefensivo() = super() + 300
    override method serOcupada(unEjercito) {habitantes=unEjercito}
}

class Ejercito {
    const tropa = []
    
    method poderOfensivo() = tropa.sum({p=>p.potencialOfensivo()})
    method invadir(unaLocalidad) {
        if(self.puedeInvadir(unaLocalidad)) {
            unaLocalidad.serOcupada(self)
        }
    }
    method puedeInvadir(unaLocalidad) {
        return self.poderOfensivo() > unaLocalidad.poderDefensivo()
    }
    method tamaño() = tropa.size()
    method losMasPorderosos() = self.ordenadosLosMasPoderosos().take(10)
    method ordenadosLosMasPoderosos() = tropa.sortBy({t1,t2=>t1.potencialOfensivo()>t2.potencialOfensivo()})
    method quitarLosMasFuertes() {
        tropa.removeAll(self.losMasPorderosos())
    }
}