get-pub:
	@echo "getting pub"
	flutter pub get

brunner:
	@echo "launching build runner"
	flutter pub run build_runner build --delete-conflicting-outputs


clean-and-run:
	@echo "cleaning and getting pub"
	flutter clean && flutter pub get

build_apk:
	flutter clean && flutter build apk --release --build-name=simplyapk

build_bundle:
	flutter clean && flutter build appbundle --release

run-splash:
	dart run flutter_native_splash:create
		
refresh:
	@echo "refreshing packages"
	flutter pub get