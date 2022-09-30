import { Column, Entity, PrimaryColumn } from "typeorm";

@Entity({name: 'CLIENTE'})
export class ClienteEntity{

  @PrimaryColumn({name: 'IDCLI', nullable: false})
  id: string;

  @Column({name:'NOMCLI', nullable:false})
  nombre: string;

  @Column({name:'APECLI', nullable:false})
  apellido: string;

  @Column({name:'TELEFCLI', nullable:false})
  movil: string;

  @Column({name:'EMAILCLI', nullable:false})
  correo: string;

  @Column({name:'DNICLI', nullable:false})
  dni: string;

  @Column({name:'ESTACLI', nullable:false})
  estado: string;
}