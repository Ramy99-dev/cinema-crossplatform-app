import {User} from "./User";
import {Movie} from "./Movie";
export class Reservation
{
    _id?:string;
    idUser?:User;
    idMovie?:Movie;
    nbr?:number;
}