import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from "@nestjs/typeorm";
import { ClienteController } from "./controllers/cliente.controller";
import { ClienteService } from "./services/cliente.service";
import { ClienteEntity} from "./entities/cliente.entity";

@Module({
  imports: [
   TypeOrmModule.forRoot({
    "type": "oracle",
    "host": "fe80::3490:8205:d669:73b8%17",
    "port": 1521,
    "username": "dbPublishned",
    "password": "12345",
    "sid": "xe",
    "entities": [__dirname + "/**/**.entity{.ts,.js}"],
    "synchronize": false,
    "logging": true
   }),
    TypeOrmModule.forFeature([ClienteEntity])
  ],
  controllers: [AppController, ClienteController],
  providers: [AppService,ClienteService],
})
export class AppModule {}
