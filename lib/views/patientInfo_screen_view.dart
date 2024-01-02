
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/patientInfo_screen_vm.dart';
import 'package:riverpod_example/views/updateInfo_screen_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class PatientInfoScreen extends ConsumerStatefulWidget {

  var hospName;
  var accessToken;
  var sId;
  var hospList;
  PatientInfoScreen( this.hospName,this.accessToken,this.sId, this.hospList);

  @override
  ConsumerState<PatientInfoScreen> createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends ConsumerState<PatientInfoScreen> with TickerProviderStateMixin{

  late PatientInfoScreenVM _vm;
  var clr = AppConstColor().appThemeColor;
  late TabController tabController;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = PatientInfoScreenVM(ref);
    Future.delayed(Duration.zero,()=>_vm.fetchPatientData(widget.accessToken, widget.sId, ));

  }

  @override
  Widget build(BuildContext context) {

    tabController = TabController(length: 5, vsync: this);
    debugPrint('Patient sId :: ${widget.sId}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: clr,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.hospName,style: const TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return UpdateInfoScreen(widget.accessToken,widget.hospList, ref.watch(_vm.data));
            }));
          },
              icon: const Icon(Icons.update, color: Colors.white,))
        ],
      ),
      body: Consumer(
        builder: (context, ref, child){
         bool isLoader =  ref.watch(_vm.isLoading);
          var data = ref.watch(_vm.data);
          return loader(data, isLoader);
        },
      ),
    );
  }

  loader(data, isLoader){
    if(isLoader== true){
      return  const Center(child: CircularProgressIndicator(),);
    }else{
      return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(child: Text('${data?.name}, ${data?.gender}')),
                    Center(child: Text('Age - ${data?.dob}'),),
                    const SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: clr),
                                    children: [
                                      const TextSpan(text: 'Ward - '),
                                      TextSpan(text: '${data?.wardId?.wardname}',style: const TextStyle(color: Colors.black))
                                    ]
                                ),),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: clr),
                                    children: [
                                      const TextSpan(text: 'M-Division - '),
                                      TextSpan(text: '${data?.medicalId?.division}',style: const TextStyle(color: Colors.black))
                                    ]
                                ),),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: clr),
                                    children: [
                                      const TextSpan(text: 'Insurance - '),
                                      TextSpan(text: '${data?.isUserBlocked}',style: const TextStyle(color: Colors.black))
                                    ]
                                ),),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: clr),
                                    children: [
                                      const TextSpan(text: 'Admitted - '),
                                      TextSpan(text: '${data?.admissionDate}',style: const TextStyle(color: Colors.black))
                                    ]
                                ),),
                            ],
                          ),
                        ),
                        const SizedBox(width: 45,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(text: TextSpan(
                                  style: TextStyle(color: clr),
                                  children: [
                                    const TextSpan(text: 'Bed - '),
                                    TextSpan(text: '${data?.bedId?.bedNumber}',style: const TextStyle(color: Colors.black))
                                  ]
                              )),
                              RichText(text: TextSpan(
                                  style: TextStyle(color: clr),
                                  children: [
                                    const TextSpan(text: 'R-ID - '),
                                    TextSpan(text: '${data?.sId}',style: const TextStyle(color: Colors.black))
                                  ]
                              )),
                              RichText(text: TextSpan(
                                  style: TextStyle(color: clr),
                                  children: [
                                    const TextSpan(text: 'Hosp.ID - '),
                                    TextSpan(text: '${data?.medicalId?.hospitalId}',style: const TextStyle(color: Colors.black))
                                  ]
                              )),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      child: TabBar(
                          controller: tabController,
                          isScrollable: true,
                          tabs: const [
                            Tab(icon: Icon(FontAwesomeIcons.stethoscope),text: 'DIAGNOSIS',),
                            Tab(icon: Icon(FontAwesomeIcons.handHoldingHeart),text: 'PALLIMATIVE',),
                            Tab(icon: Icon(FontAwesomeIcons.sketch),text: 'STATUS',),
                            Tab(icon: Icon(FontAwesomeIcons.watchmanMonitoring),text: 'MONITOR',),
                            Tab(icon: Icon(FontAwesomeIcons.solidNoteSticky),text: 'NT',),

                          ]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBarView(
                            controller: tabController,
                            children: [
                              //TabBar 1
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                color: clr
                                            ),
                                            child: const Row(
                                              children: [
                                                Text('Diagonosis',style: TextStyle(color: Colors.white),),
                                                Spacer(),
                                                Icon(Icons.refresh,color: Colors.white,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                color: clr
                                            ),
                                            child: const Row(
                                              children: [
                                                Text('Observations / Family History',style: TextStyle(color: Colors.white),),
                                                Spacer(),
                                                Icon(Icons.refresh,color: Colors.white,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //TabBar 2
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                color: clr
                                            ),
                                            child: const Row(
                                              children: [
                                                Text('Goals',style: TextStyle(color: Colors.white),),
                                                Spacer(),
                                                Icon(Icons.refresh,color: Colors.white,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 180,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 2,color: clr),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                IconButton(onPressed: (){

                                                },
                                                    icon: const Icon(Icons.refresh)),
                                                const Center(child: Text('AKPS - 100%'))
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 6,),
                                        Expanded(
                                          child: Container(
                                            height: 180,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 2,color: clr),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                IconButton(onPressed: (){

                                                },
                                                    icon: const Icon(Icons.refresh)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              //TabBar 3
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                color: clr
                                            ),
                                            child: const Row(
                                              children: [
                                                Text('Anthropometry',style: TextStyle(color: Colors.white),),
                                                Spacer(),
                                                Icon(Icons.refresh,color: Colors.white,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: PageView(
                                        controller: pageController,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Nutritional Screening',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Nutritional Screening',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Nutritional Screening',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Nutritional Screening',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    SmoothPageIndicator(
                                      controller: pageController,
                                      count: 4,
                                      effect: WormEffect(
                                          dotColor: Colors.grey,
                                          activeDotColor: clr,
                                          dotHeight: 5,
                                          dotWidth: 30
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //TabBar 4
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                color: clr
                                            ),
                                            child: const Row(
                                              children: [
                                                Text('Summary',style: TextStyle(color: Colors.white),),
                                                Spacer(),
                                                Icon(Icons.refresh,color: Colors.white,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: PageView(
                                        controller: pageController,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Fluid Balance',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Fluid Balance',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Fluid Balance',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Fluid Balance',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Fluid Balance',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Fluid Balance',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    SmoothPageIndicator(
                                      controller: pageController,
                                      count: 6,
                                      effect: WormEffect(
                                          dotWidth: 30,
                                          dotHeight: 5,
                                          dotColor: Colors.grey,
                                          activeDotColor: clr
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // TabBar 5
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                color: clr
                                            ),
                                            child: const Row(
                                              children: [
                                                Text('Needs (Achieved %)',style: TextStyle(color: Colors.white),),
                                                Spacer(),
                                                Icon(Icons.refresh,color: Colors.white,)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: clr),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: PageView(
                                        controller: pageController,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Parenteral Nutrition',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Parenteral Nutrition',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Parenteral Nutrition',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Parenteral Nutrition',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Parenteral Nutrition',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Parenteral Nutrition',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Parenteral Nutrition',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(9),topLeft: Radius.circular(9)),
                                                    color: clr
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Text('Parenteral Nutrition',style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.refresh,color: Colors.white,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    SmoothPageIndicator(
                                      controller: pageController,
                                      count: 8,
                                      effect: WormEffect(
                                          dotWidth: 30,
                                          dotHeight: 5,
                                          dotColor: Colors.grey,
                                          activeDotColor: clr
                                      ),
                                    )

                                  ],
                                ),
                              ),

                            ]),
                      ),
                    ),
                  ],
                ),
              )
              //Tab start
            ],
          )
      );
    }
  }


}
