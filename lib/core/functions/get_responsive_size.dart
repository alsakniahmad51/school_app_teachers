import 'package:flutter/material.dart';

const double kDesignWidth = 412;
const double kDesignHeight = 892;

double _getResponsiveWidth(BuildContext context, double size) {
  final double width = MediaQuery.of(context).size.width;
  return (width / kDesignWidth) * size;
}

double _getResponsiveHeight(BuildContext context, double size) {
  final double height = MediaQuery.of(context).size.height;
  return (height / kDesignHeight) * size;
}




double _getResponsiveRadius(BuildContext context, double size) {
  return _getResponsiveWidth(context, size);
}

double _getResponsiveFontSize(BuildContext context, double size) {
  final double width = MediaQuery.of(context).size.width;
  final double scaleFactor = width / kDesignWidth;
  return size * scaleFactor.clamp(0.5, 1.5);
}

double _getResponsiveSize(BuildContext context, double size) {
  final width = _getResponsiveWidth(context, size);
  final height = _getResponsiveHeight(context, size);
  return (width + height) / 2;
}

extension DoubleResponsiveExtensions on double {
  double w(BuildContext context) => _getResponsiveWidth(context, this);
  double h(BuildContext context) => _getResponsiveHeight(context, this);
  double r(BuildContext context) => _getResponsiveRadius(context, this);
  double fs(BuildContext context) => _getResponsiveFontSize(context, this);
  double s(BuildContext context) => _getResponsiveSize(context, this);}

extension IntResponsiveExtensions on int {
  double w(BuildContext context) => _getResponsiveWidth(context, toDouble());
  double h(BuildContext context) => _getResponsiveHeight(context, toDouble());
  double r(BuildContext context) => _getResponsiveRadius(context, toDouble());
  double fs(BuildContext context) => _getResponsiveFontSize(context, toDouble());
  double s(BuildContext context) => _getResponsiveSize(context, toDouble());
}
