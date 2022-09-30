import { Body, Controller, Delete, Get, Param, Post, Put } from "@nestjs/common";
import { ClienteService } from "../services/cliente.service";
import { ClienteEntity } from "../entities/cliente.entity";

@Controller('clientes')
export class ClienteController{
  constructor(private ClienteService: ClienteService) {
  }

  @Post()
  async register(@Body() cliente: ClienteEntity): Promise<ClienteEntity> {
    return this.ClienteService.register(cliente);
  }

  @Put()
  async update(@Body() cliente: ClienteEntity): Promise<ClienteEntity> {
    return this.ClienteService.update(cliente);
  }

  @Get()
  async findAll(): Promise<ClienteEntity[]> {
    return this.ClienteService.finAll();
  }

  @Get(":id")
  findById(@Param("id") id: string) {
    return this.ClienteService.findById(id);
  }

  @Delete(":id")
  deleteByid(@Param("id")id: string){
    return this.ClienteService.delete(id);
  }
}