// ignore_for_file: constant_identifier_names

class Apis {

  static const domain = 'http://103.205.64.220:17250/WhatsappMobileAPILive/api1';

  // login
  static const postAuthTkn = '$domain/GetAuthToken';
  static const postLogin = '$domain/Login';

  // dashboard
  static const getDashboard  = '$domain/UserDashboard';

  //ActiveChat
  static const getActiveChat  = '$domain/GetloadChatBox';

  //OldChat
  static const getOldChat  = '$domain/GetLoadOldChatBox';

  //SortChat
  static const getChatSort = '$domain/GetLoadShortingLabelWiseChat?CheckOld=';

  //UnreadChat
  static const getUnreadChat = '$domain/GetLoadFilterUnreadChatBox?CheckOld=';

  //GetChatLabel
  static const getChatLabel = '$domain/GetFlag?CustomerMob=';

  //AddChatLabel
  static const addChatLabel = '$domain/AddNewLabel';

  //EditChatLabel
  static const editChatLabel = '$domain/EditFlag';

  //DeleteChatLabel
  static const deleteChatLabel = '$domain/DeleteFlag';

  //GetIndividualChatMessage
  static const getIndividualChatMessage = '$domain/GetClickChatMessage';

  //SendMessage
  static const sendMessage = '$domain/sendwaba';

  //SendFile
  static const sendFile = '$domain/UploadFile';

  //Save Flag
  static const saveFlag = '$domain/SaveFlag';

  //Unread Message
  static const unreadMessage = '$domain/UpdateUnreadMessage';

  //Get Filtered Chat
  static const getFilteredChat = '$domain/GetLoadFilterChatBox?';
}