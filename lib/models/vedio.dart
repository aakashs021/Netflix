class Vedio{
 String key;
 String type;
 Vedio({required this.key,required this.type}); 

 factory Vedio.fromJson({required Map<String,dynamic> json}){
  return Vedio(key: json['key'], type: json['type']);
 }
}