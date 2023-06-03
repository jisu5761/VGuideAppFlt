

const String AMI_CHARACTERISTIC_UUID          =      "beb5483e-36e1-4688-b7f5-ea07361b26a8";
const String AMI_UART_SERVICE 					      = "0003cdd0-0000-1000-8000-00805f9b0131";
const String AMI_UART_WRITE_CHARACTERISTIC 		= "0003cdd1-0000-1000-8000-00805f9b0131";
const String AMI_UART_READ_CHARACTERISTIC 		= "0003cdd2-0000-1000-8000-00805f9b0131";

// public static String WOOIN_SERVICE 					= "0000fff0-0000-1000-8000-00805F9B34FB";
// public static String WOOIN_NOTIFY_CHARACTERISTIC 	= "0000ff03-0000-1000-8000-00805F9B34FB";
// public static String WOOIN_WRITE_CHARACTERISTIC 	= "0000ff01-0000-1000-8000-00805F9B34FB";
// public static String WOOIN_READ_CHARACTERISTIC 		= "0000ff02-0000-1000-8000-00805F9B34FB";
//
//
const String WOO_UART_SERVICE 					      = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
const String WOO_UART_WRITE_CHARACTERISTIC 		= "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
const String WOO_UART_READ_CHARACTERISTIC 		= "6e400002-b5a3-f393-e0a9-e50e24dcca9e";
// public static String UART_WRITE_DESCRIPTE		     = "00002902-0000-1000-8000-00805f9b34fb";



const String HAN_UART_SERVICE                 = "0003cdd0-0000-1000-8000-00805f9b0131";
const String HAN_UART_WRITE_CHARACTERISTIC    = "0003cdd1-0000-1000-8000-00805f9b0131";
const String HAN_UART_READ_CHARACTERISTIC     = "0003cdd2-0000-1000-8000-00805f9b0131";

const cmdbase = [0xA2,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0xA3 ];

const List<String> sexList = ['여자', '남자'];
const List<String> birdCricketList = ['새', '귀뚜라미'];
const List<String> crossList = ['교차로', '단일로'];
const List<String> pillarList = ['일반지주', '근접지주', '동일지주'];
const List<String> setupList = ['미설정', '설정'];
const List<String> afterList = ['먼저', '나중'];

const double  dropboxWidth =  90.0;
const double  elevatedbuttonheight =  50.0;

enum  UuidSel {
  WOOIN_UUID,
  ETC_UUID
}

int uuidsel = 0;
bool isReady = false;
