import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { ClienteEntity } from "../entities/cliente.entity";
import { Repository } from "typeorm";


@Injectable()
export class ClienteService{

  constructor(@InjectRepository(ClienteEntity) private ClienteRepository: Repository<ClienteEntity>) {
  }

  register(cliente: ClienteEntity) {
    return this.ClienteRepository.save(cliente);
  }

  update(cliente: ClienteEntity) {
    return this.ClienteRepository.save(cliente)
  }

  finAll(){
    return this.ClienteRepository.find();
  }

  delete(id: string) {
    return this.ClienteRepository.delete(id);
  }

  findById(id: string) {
    return this.ClienteRepository.findBy({id})
  }
}