/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 1
/// Strings: 20
///
/// Built on 2024-06-03 at 09:43 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsHomeEn home = _TranslationsHomeEn._(_root);
	late final _TranslationsRatePopupEn rate_popup = _TranslationsRatePopupEn._(_root);
	late final _TranslationsPremiumEn premium = _TranslationsPremiumEn._(_root);
}

// Path: home
class _TranslationsHomeEn {
	_TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'ApparenceKit example';
}

// Path: rate_popup
class _TranslationsRatePopupEn {
	_TranslationsRatePopupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Would you have 15s to rate us?';
	String get description => 'It\'s fast and very helpful! Thanks a lot!';
	String get cancel_button => 'Maybe later';
	String get rate_button => 'Yes, with pleasure!';
}

// Path: premium
class _TranslationsPremiumEn {
	_TranslationsPremiumEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title_1 => 'Unlock full access';
	String get description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
	String get feature_1 => 'Lorem ipsum dolor sit ame lorem';
	String get feature_2 => 'Lorem ipsum dolor sit ame lorem';
	String get feature_3 => 'Lorem ipsum dolor sit ame lorem';
	String get duration_annual => 'Year';
	String get duration_annual_description => 'Save 50%';
	String get duration_monthly => 'Month';
	String get duration_monthly_description => 'Cancel anytime';
	String get duration_lifetime => 'Lifetime';
	String get duration_lifetime_description => 'One time payment';
	String get restore_action => 'Restore my subscription';
	String get payment_cancel_reassurance => 'Easy 1-click cancel, always';
	String get payment_action => 'Start free trial';
	String payment_action_trial({required Object money}) => '7-day free trial, then ${money}';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'home.title': return 'ApparenceKit example';
			case 'rate_popup.title': return 'Would you have 15s to rate us?';
			case 'rate_popup.description': return 'It\'s fast and very helpful! Thanks a lot!';
			case 'rate_popup.cancel_button': return 'Maybe later';
			case 'rate_popup.rate_button': return 'Yes, with pleasure!';
			case 'premium.title_1': return 'Unlock full access';
			case 'premium.description': return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
			case 'premium.feature_1': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.feature_2': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.feature_3': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.duration_annual': return 'Year';
			case 'premium.duration_annual_description': return 'Save 50%';
			case 'premium.duration_monthly': return 'Month';
			case 'premium.duration_monthly_description': return 'Cancel anytime';
			case 'premium.duration_lifetime': return 'Lifetime';
			case 'premium.duration_lifetime_description': return 'One time payment';
			case 'premium.restore_action': return 'Restore my subscription';
			case 'premium.payment_cancel_reassurance': return 'Easy 1-click cancel, always';
			case 'premium.payment_action': return 'Start free trial';
			case 'premium.payment_action_trial': return ({required Object money}) => '7-day free trial, then ${money}';
			default: return null;
		}
	}
}
