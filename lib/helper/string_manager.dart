abstract class StringManager {
  //users collection
  static const usersCollectionKey = 'users';
  static const userNameKey = 'name';
  static const userIdKey = 'uid';
  static const freeCreditKey = 'freeCredit';
  static const isSubscribedKey = 'isSubscribed';
  static const freeCreditPropertyBoxKey = 'freeCreditPropertyBox';
  static const countryCodeKey = 'countryCode';
  static const phoneNumberKey = 'phone';
  static const counterKey = 'counter';
  static const walletAmountKey = 'wallet_amount';
  static const locationKey = 'location';
  static const referralCodeKey = 'ref_code';
  static const emailKey = 'email';
  static const agentExpKey = 'agent_exp';
  static const profilePicKey = 'profile_pic';

  //projects collection
  static const projectsCollectionKey = 'projects';
  static const approvedByKey = 'approvedBy';
  static const companyNameKey = 'companyName';
  static const docsKey = 'docs';
  static const imagesKey = 'images';
  static const videosKey = 'videos';
  static const isExportKey = 'isExport';
  static const latitudeKey = 'latitude';
  static const longitudeKey = 'longitude';
  static const possessionStateKey = 'possessionState';
  static const pricePerUnitDropDown = 'pricePerUnitDropDow';
  static const pricePerUnitText = 'pricePerUnitText';
  static const projectCategory = 'projectCategory';
  static const projectLocation = 'projectLocation';
  static const totalProject = 'totalProject';
  static const totalUnits = 'totalUnits';
  static const unitSizeDropDown = 'unitSizeDropDown';
  static const unitSizeOne = 'unitSizeOne';
  static const unitSizeTwo = 'unitSizeTwo';
  static const userId = 'userId';
  static const ventureName = 'ventureName';

  //sell_plots collection

  static const age = 'age';
  static const boxEnabled = 'box_enabled';
  static const facing = 'facing';
  static const handOverMonth = 'handOverMonth';
  static const handOverYear = 'handOverYear';
  static const isPaid = 'isPaid';
  static const location = 'location';
  static const possessionStatus = 'possessionStatus';
  static const price = 'price';
  static const profileImage = 'profile_image';
  static const propertyCategory = 'propertyCategory';
  static const propertyType = 'propertyType';
  static const size = 'size';
  static const timestamp = 'timestamp';
  static const furnished = 'furnished';
  static const floors = 'floors';
  static const bedRoom = 'bed_room';
  static const bathRoom = 'bath_room';
  static const extraRoom = 'extra_room';
  static const carPark = 'car_park';
  static const totalPortion = 'total_portion';
  static const totalIncome = 'total_income';
  static const rentalIncome = 'rental_income';

  //errors
  static const somethingWentWrong = "Somethig Went Wrong Please Try Later";
  static const noUsersFoundError = "No users Found";
  static const noPlotsFoundError = 'No Plots Found';

  //onbaording
  static const isOnboardingSeen = "isOnboardingSeen";

  // Location string
  static const disabledLocationError = "Location services are disabled.";
  static const locationPermissionDeniedError =
      "Location permissions are denied";
  static const locationPermissionDeniedForeverError =
      "Location permissions are permanently denied, we cannot request permissions.";

  static const openLocationMsg = "Please open location service";
  static const allowLocationPermissionMsg = 'Please Allow Location Permission.';
  static const locationPermanentlyDeniedMsg =
      "You are permanently denied location permission, Please Allow manually";
}
