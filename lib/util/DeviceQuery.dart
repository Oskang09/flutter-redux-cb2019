import 'package:flutter/widgets.dart';

class DeviceQuery {
    
    MediaQueryData _media;

    DeviceQuery(BuildContext context) {
        _media = MediaQuery.of(context);    
    }
    
    double getXdp(percentage) {
        return _media.size.width * ( percentage / 100 );
    }

    double getYdp(percentage) {
        return _media.size.height * (percentage / 100 );
    }
}