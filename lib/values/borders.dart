part of values;

class Borders {
  static const BorderSide defaultPrimaryBorder =
      BorderSide(width: Sizes.WIDTH_0, style: BorderStyle.none);

  static const UnderlineInputBorder ButtonBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.whiteShade1,
      width: Sizes.WIDTH_1,
      style: BorderStyle.solid,
    ),
  );

  static const UnderlineInputBorder primaryInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.whiteShade1,
      width: Sizes.WIDTH_1,
      style: BorderStyle.solid,
    ),
  );

  static const UnderlineInputBorder enabledBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.purple,
      width: Sizes.WIDTH_1,
      style: BorderStyle.solid,
    ),
  );

  static const UnderlineInputBorder focusedBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.blackShade3,
      width: Sizes.WIDTH_2,
      style: BorderStyle.solid,
    ),
  );

  static const UnderlineInputBorder disabledBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.grey,
      width: Sizes.WIDTH_1,
      style: BorderStyle.solid,
    ),
  );

  static const UnderlineInputBorder errorBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.red,
      width: Sizes.WIDTH_2,
      style: BorderStyle.solid,
    ),
  );

  static const OutlineInputBorder outlineEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_30)),
    borderSide: BorderSide(
      color: AppColors.purple,
      width: Sizes.WIDTH_1,
      style: BorderStyle.solid,
    ),
  );

  static const OutlineInputBorder outlineFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_30)),
    borderSide: BorderSide(
      color: AppColors.blackShade3,
      width: Sizes.WIDTH_1,
      style: BorderStyle.solid,
    ),
  );

  static const OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_30)),
    borderSide: BorderSide(
      color: AppColors.grey,
      width: Sizes.WIDTH_1,
      style: BorderStyle.solid,
    ),
  );

  static const OutlineInputBorder outlineErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_30)),
    borderSide: BorderSide(
      color: AppColors.red,
      width: Sizes.WIDTH_2,
      style: BorderStyle.solid,
    ),
  );

  static const UnderlineInputBorder noBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.none,
    ),
  );

  static customBorder({
    Color color = AppColors.blackShade10,
    double width = Sizes.WIDTH_1,
    BorderStyle style = BorderStyle.solid,
  }) {
    return BorderSide(
      color: color,
      width: width,
      style: style,
    );
  }

  static customButtonBorder({
    double borderRadius = Sizes.RADIUS_12,
    Color color = AppColors.grey,
    double width = Sizes.WIDTH_1,
    BorderStyle style = BorderStyle.solid,
  }) {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: color,
            width: width,
            style: style,
          ),
        ),
      ),
    );
  }

  static customOutlineInputBorder({
    double borderRadius = Sizes.RADIUS_12,
    Color color = AppColors.grey,
    double width = Sizes.WIDTH_1,
    BorderStyle style = BorderStyle.solid,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      borderSide: BorderSide(
        color: color,
        width: width,
        style: style,
      ),
    );
  }

  static customUnderlineInputBorder({
    Color color = AppColors.grey,
    double width = Sizes.WIDTH_1,
    BorderStyle style = BorderStyle.solid,
  }) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
        style: style,
      ),
    );
  }
}
