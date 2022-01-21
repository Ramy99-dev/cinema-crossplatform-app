import { Category } from "./Category";

export class Movie
{
   _id?:string  ;
   titre?:string ;
   realisateur?:string;
   description?:string;
   categorie?:Category;
   duree?:number;
   img?:string;
   dateSortie?:string;
   prix? : string;
   date?:Date|string;
   nbr?:number;
}