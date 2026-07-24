import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'M-Pesa Balance Predictor',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),

        useMaterial3: true,

      ),

      home: const PredictionPage(),

    );

  }

}



class PredictionPage extends StatefulWidget {

  const PredictionPage({super.key});


  @override
  State<PredictionPage> createState() => _PredictionPageState();

}



class _PredictionPageState extends State<PredictionPage> {


  final amountController = TextEditingController();

  final senderBeforeController = TextEditingController();

  final senderAfterController = TextEditingController();

  final receiverBeforeController = TextEditingController();



  String result = "";

  bool loading = false;



  // Dropdown values

  int transactionType = 1;

  int deviceType = 1;

  int region = 1;



  Future<void> makePrediction() async {


    if(
    amountController.text.isEmpty ||
    senderBeforeController.text.isEmpty ||
    senderAfterController.text.isEmpty ||
    receiverBeforeController.text.isEmpty
    ){

      setState((){

        result = "Please fill all fields";

      });

      return;

    }



    setState((){

      loading = true;

      result = "";

    });



    try{


      var prediction = await ApiService.predictBalance(


        amount: double.parse(amountController.text),


        senderBalanceBefore:
        double.parse(senderBeforeController.text),


        senderBalanceAfter:
        double.parse(senderAfterController.text),


        receiverBalanceBefore:
        double.parse(receiverBeforeController.text),



        transactionType: transactionType,

        hour: 14,

        month: 7,

        dayOfWeek: 3,

        deviceType: deviceType,

        region: region,

        isFraud: 0,


      );



      setState((){


        result =

        "💰 Receiver Balance\n\n"

        "${prediction["predicted_receiver_balance_after"]} RWF\n\n"

        "🛡 Status\n\n"

        "Safe Transaction\n\n"

        "📍 Region\n\n"

        "${getRegionName(region)}";


      });



    }catch(e){


      setState((){

        result = "Error connecting to server";

      });


    }



    setState((){

      loading = false;

    });


  }






  String getRegionName(int value){

    switch(value){

      case 1:
        return "Nairobi";

      case 2:
        return "Mombasa";

      case 3:
        return "Kisumu";

      default:
        return "Unknown";

    }

  }







  Widget inputField(

      String label,

      IconData icon,

      TextEditingController controller

      ){


    return Padding(

      padding: const EdgeInsets.symmetric(vertical:8),


      child: TextField(

        controller: controller,

        keyboardType: TextInputType.number,


        decoration: InputDecoration(

          labelText: label,

          prefixIcon: Icon(icon),


          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(15),

          ),

        ),

      ),

    );


  }








  Widget dropdownField(

      String label,

      int value,

      List<DropdownMenuItem<int>> items,

      Function(int?) onChanged

      ){


    return Padding(

      padding: const EdgeInsets.symmetric(vertical:8),


      child: DropdownButtonFormField<int>(


        value: value,


        decoration: InputDecoration(

          labelText: label,

          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(15),

          ),

        ),


        items: items,


        onChanged: onChanged,


      ),

    );


  }









  @override
  Widget build(BuildContext context){


    return Scaffold(


      backgroundColor: Colors.grey[100],



      appBar: AppBar(


        title: const Text(
            "M-Pesa Balance Predictor"
        ),


        centerTitle: true,


      ),




      body: SingleChildScrollView(


        padding: const EdgeInsets.all(20),



        child: Column(


          children: [



            Card(


              elevation:5,


              child: Padding(


                padding: const EdgeInsets.all(15),


                child: Column(


                  children: [



                    const Text(

                      "Transaction Details",

                      style: TextStyle(

                        fontSize:22,

                        fontWeight:FontWeight.bold,

                      ),

                    ),



                    inputField(

                        "Amount",

                        Icons.money,

                        amountController

                    ),



                    inputField(

                        "Sender Balance Before",

                        Icons.account_balance_wallet,

                        senderBeforeController

                    ),



                    inputField(

                        "Sender Balance After",

                        Icons.remove_circle,

                        senderAfterController

                    ),



                    inputField(

                        "Receiver Balance Before",

                        Icons.person,

                        receiverBeforeController

                    ),







                    dropdownField(

                      "Transaction Type",

                      transactionType,


                      const [

                        DropdownMenuItem(

                            value:1,

                            child:Text("Send Money")

                        ),

                        DropdownMenuItem(

                            value:2,

                            child:Text("Buy Goods")

                        ),

                        DropdownMenuItem(

                            value:3,

                            child:Text("Pay Bill")

                        ),

                      ],


                          (value){

                        setState((){

                          transactionType=value!;

                        });

                      },

                    ),






                    dropdownField(

                      "Device Type",

                      deviceType,


                      const [

                        DropdownMenuItem(

                            value:1,

                            child:Text("Android")

                        ),

                        DropdownMenuItem(

                            value:2,

                            child:Text("iPhone")

                        ),

                        DropdownMenuItem(

                            value:3,

                            child:Text("Web")

                        ),

                      ],


                          (value){

                        setState((){

                          deviceType=value!;

                        });

                      },

                    ),








                    dropdownField(

                      "Region",

                      region,


                      const [

                        DropdownMenuItem(

                            value:1,

                            child:Text("Nairobi")

                        ),

                        DropdownMenuItem(

                            value:2,

                            child:Text("Mombasa")

                        ),

                        DropdownMenuItem(

                            value:3,

                            child:Text("Kisumu")

                        ),

                      ],


                          (value){

                        setState((){

                          region=value!;

                        });

                      },


                    ),



                  ],


                ),

              ),


            ),






            const SizedBox(height:25),





            SizedBox(

              width:double.infinity,


              child:ElevatedButton(


                onPressed:
                loading ? null : makePrediction,


                child:

                loading

                ?

                const CircularProgressIndicator()

                :

                const Text(

                  "Predict Balance",

                  style:TextStyle(fontSize:18),

                ),


              ),


            ),







            const SizedBox(height:25),




            if(result.isNotEmpty)


              Card(


                color:Colors.green[50],


                elevation:5,


                child:Padding(


                  padding:const EdgeInsets.all(20),


                  child:Text(


                    result,


                    textAlign:TextAlign.center,


                    style:const TextStyle(

                      fontSize:20,

                      fontWeight:FontWeight.bold,

                    ),


                  ),


                ),


              )




          ],


        ),


      ),


    );


  }


}