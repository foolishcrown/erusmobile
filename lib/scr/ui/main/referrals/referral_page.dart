import 'package:erusmobile/scr/ui/main/referrals/referral_list.dart';
import 'package:flutter/material.dart';

class ReferralsPage extends StatefulWidget {
  final int empId;

  const ReferralsPage(
      {Key key, @required this.empId})
      : super(key: key);

  @override
  _ReferralsPageState createState() => _ReferralsPageState();
}

class _ReferralsPageState extends State<ReferralsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReferralList(empId: widget.empId),
    );
  }
}
