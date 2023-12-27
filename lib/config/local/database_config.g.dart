// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_config.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDatabaseConfig {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseConfigBuilder databaseBuilder(String name) =>
      _$DatabaseConfigBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseConfigBuilder inMemoryDatabaseBuilder() =>
      _$DatabaseConfigBuilder(null);
}

class _$DatabaseConfigBuilder {
  _$DatabaseConfigBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DatabaseConfigBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DatabaseConfigBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DatabaseConfig> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DatabaseConfig();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseConfig extends DatabaseConfig {
  _$DatabaseConfig([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProfileDao? _profileDaoInstance;

  PengaturanAutocodeAndroidDao? _pengaturanAutocodeAndroidDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `profile` (`userId` INTEGER NOT NULL, `nik` TEXT, `username` TEXT, `password` TEXT, `typeuserCode` TEXT, `typeuserName` TEXT, `code` TEXT, `name` TEXT, `address` TEXT, `tempatLahir` TEXT, `tglLahir` TEXT, `tglMasuk` TEXT, `email` TEXT, `phone1` TEXT, `phone2` TEXT, `photo` TEXT, `photoKtp` TEXT, `noKtp` TEXT, `typeuserId` TEXT, `divisiCode` TEXT, `jabatanCode` TEXT, `deviceId` TEXT, `deviceBrand` TEXT, `deviceType` TEXT, `firebaseId` TEXT, `costCenterCode` TEXT, `lokasi` TEXT, `organizationLevel` TEXT, `isUpdated` INTEGER, `status` INTEGER, `statusKirim` INTEGER, `createdAt` TEXT, `updatedAt` TEXT, PRIMARY KEY (`userId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `pengaturan_autocode_android` (`code` TEXT NOT NULL, `value` TEXT, `count` TEXT, `status` INTEGER, `statusKirim` INTEGER, `createdAt` TEXT, `updatedAt` TEXT, PRIMARY KEY (`code`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProfileDao get profileDao {
    return _profileDaoInstance ??= _$ProfileDao(database, changeListener);
  }

  @override
  PengaturanAutocodeAndroidDao get pengaturanAutocodeAndroidDao {
    return _pengaturanAutocodeAndroidDaoInstance ??=
        _$PengaturanAutocodeAndroidDao(database, changeListener);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _profileEntityInsertionAdapter = InsertionAdapter(
            database,
            'profile',
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'nik': item.nik,
                  'username': item.username,
                  'password': item.password,
                  'typeuserCode': item.typeuserCode,
                  'typeuserName': item.typeuserName,
                  'code': item.code,
                  'name': item.name,
                  'address': item.address,
                  'tempatLahir': item.tempatLahir,
                  'tglLahir': item.tglLahir,
                  'tglMasuk': item.tglMasuk,
                  'email': item.email,
                  'phone1': item.phone1,
                  'phone2': item.phone2,
                  'photo': item.photo,
                  'photoKtp': item.photoKtp,
                  'noKtp': item.noKtp,
                  'typeuserId': item.typeuserId,
                  'divisiCode': item.divisiCode,
                  'jabatanCode': item.jabatanCode,
                  'deviceId': item.deviceId,
                  'deviceBrand': item.deviceBrand,
                  'deviceType': item.deviceType,
                  'firebaseId': item.firebaseId,
                  'costCenterCode': item.costCenterCode,
                  'lokasi': item.lokasi,
                  'organizationLevel': item.organizationLevel,
                  'isUpdated': item.isUpdated,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _profileEntityUpdateAdapter = UpdateAdapter(
            database,
            'profile',
            ['userId'],
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'nik': item.nik,
                  'username': item.username,
                  'password': item.password,
                  'typeuserCode': item.typeuserCode,
                  'typeuserName': item.typeuserName,
                  'code': item.code,
                  'name': item.name,
                  'address': item.address,
                  'tempatLahir': item.tempatLahir,
                  'tglLahir': item.tglLahir,
                  'tglMasuk': item.tglMasuk,
                  'email': item.email,
                  'phone1': item.phone1,
                  'phone2': item.phone2,
                  'photo': item.photo,
                  'photoKtp': item.photoKtp,
                  'noKtp': item.noKtp,
                  'typeuserId': item.typeuserId,
                  'divisiCode': item.divisiCode,
                  'jabatanCode': item.jabatanCode,
                  'deviceId': item.deviceId,
                  'deviceBrand': item.deviceBrand,
                  'deviceType': item.deviceType,
                  'firebaseId': item.firebaseId,
                  'costCenterCode': item.costCenterCode,
                  'lokasi': item.lokasi,
                  'organizationLevel': item.organizationLevel,
                  'isUpdated': item.isUpdated,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _profileEntityDeletionAdapter = DeletionAdapter(
            database,
            'profile',
            ['userId'],
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'nik': item.nik,
                  'username': item.username,
                  'password': item.password,
                  'typeuserCode': item.typeuserCode,
                  'typeuserName': item.typeuserName,
                  'code': item.code,
                  'name': item.name,
                  'address': item.address,
                  'tempatLahir': item.tempatLahir,
                  'tglLahir': item.tglLahir,
                  'tglMasuk': item.tglMasuk,
                  'email': item.email,
                  'phone1': item.phone1,
                  'phone2': item.phone2,
                  'photo': item.photo,
                  'photoKtp': item.photoKtp,
                  'noKtp': item.noKtp,
                  'typeuserId': item.typeuserId,
                  'divisiCode': item.divisiCode,
                  'jabatanCode': item.jabatanCode,
                  'deviceId': item.deviceId,
                  'deviceBrand': item.deviceBrand,
                  'deviceType': item.deviceType,
                  'firebaseId': item.firebaseId,
                  'costCenterCode': item.costCenterCode,
                  'lokasi': item.lokasi,
                  'organizationLevel': item.organizationLevel,
                  'isUpdated': item.isUpdated,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProfileEntity> _profileEntityInsertionAdapter;

  final UpdateAdapter<ProfileEntity> _profileEntityUpdateAdapter;

  final DeletionAdapter<ProfileEntity> _profileEntityDeletionAdapter;

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM profile');
  }

  @override
  Future<List<ProfileEntity>> getProfile() async {
    return _queryAdapter.queryList('SELECT * FROM profile',
        mapper: (Map<String, Object?> row) => ProfileEntity(
            userId: row['userId'] as int,
            username: row['username'] as String?,
            password: row['password'] as String?,
            typeuserCode: row['typeuserCode'] as String?,
            typeuserName: row['typeuserName'] as String?,
            nik: row['nik'] as String?,
            code: row['code'] as String?,
            name: row['name'] as String?,
            address: row['address'] as String?,
            tempatLahir: row['tempatLahir'] as String?,
            tglLahir: row['tglLahir'] as String?,
            tglMasuk: row['tglMasuk'] as String?,
            email: row['email'] as String?,
            phone1: row['phone1'] as String?,
            phone2: row['phone2'] as String?,
            photo: row['photo'] as String?,
            photoKtp: row['photoKtp'] as String?,
            noKtp: row['noKtp'] as String?,
            typeuserId: row['typeuserId'] as String?,
            divisiCode: row['divisiCode'] as String?,
            jabatanCode: row['jabatanCode'] as String?,
            deviceId: row['deviceId'] as String?,
            deviceBrand: row['deviceBrand'] as String?,
            deviceType: row['deviceType'] as String?,
            firebaseId: row['firebaseId'] as String?,
            costCenterCode: row['costCenterCode'] as String?,
            lokasi: row['lokasi'] as String?,
            organizationLevel: row['organizationLevel'] as String?,
            isUpdated: row['isUpdated'] as int?,
            status: row['status'] as int?,
            statusKirim: row['statusKirim'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?));
  }

  @override
  Future<List<ProfileEntity>> getProfileById(int userId) async {
    return _queryAdapter.queryList('SELECT * FROM profile WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => ProfileEntity(
            userId: row['userId'] as int,
            username: row['username'] as String?,
            password: row['password'] as String?,
            typeuserCode: row['typeuserCode'] as String?,
            typeuserName: row['typeuserName'] as String?,
            nik: row['nik'] as String?,
            code: row['code'] as String?,
            name: row['name'] as String?,
            address: row['address'] as String?,
            tempatLahir: row['tempatLahir'] as String?,
            tglLahir: row['tglLahir'] as String?,
            tglMasuk: row['tglMasuk'] as String?,
            email: row['email'] as String?,
            phone1: row['phone1'] as String?,
            phone2: row['phone2'] as String?,
            photo: row['photo'] as String?,
            photoKtp: row['photoKtp'] as String?,
            noKtp: row['noKtp'] as String?,
            typeuserId: row['typeuserId'] as String?,
            divisiCode: row['divisiCode'] as String?,
            jabatanCode: row['jabatanCode'] as String?,
            deviceId: row['deviceId'] as String?,
            deviceBrand: row['deviceBrand'] as String?,
            deviceType: row['deviceType'] as String?,
            firebaseId: row['firebaseId'] as String?,
            costCenterCode: row['costCenterCode'] as String?,
            lokasi: row['lokasi'] as String?,
            organizationLevel: row['organizationLevel'] as String?,
            isUpdated: row['isUpdated'] as int?,
            status: row['status'] as int?,
            statusKirim: row['statusKirim'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?),
        arguments: [userId]);
  }

  @override
  Future<void> insertEntity(ProfileEntity model) async {
    await _profileEntityInsertionAdapter.insert(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateEntity(ProfileEntity model) async {
    await _profileEntityUpdateAdapter.update(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEntity(ProfileEntity model) async {
    await _profileEntityDeletionAdapter.delete(model);
  }
}

class _$PengaturanAutocodeAndroidDao extends PengaturanAutocodeAndroidDao {
  _$PengaturanAutocodeAndroidDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pengaturanAutocodeAndroidEntityInsertionAdapter = InsertionAdapter(
            database,
            'pengaturan_autocode_android',
            (PengaturanAutocodeAndroidEntity item) => <String, Object?>{
                  'code': item.code,
                  'value': item.value,
                  'count': item.count,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _pengaturanAutocodeAndroidEntityUpdateAdapter = UpdateAdapter(
            database,
            'pengaturan_autocode_android',
            ['code'],
            (PengaturanAutocodeAndroidEntity item) => <String, Object?>{
                  'code': item.code,
                  'value': item.value,
                  'count': item.count,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _pengaturanAutocodeAndroidEntityDeletionAdapter = DeletionAdapter(
            database,
            'pengaturan_autocode_android',
            ['code'],
            (PengaturanAutocodeAndroidEntity item) => <String, Object?>{
                  'code': item.code,
                  'value': item.value,
                  'count': item.count,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PengaturanAutocodeAndroidEntity>
      _pengaturanAutocodeAndroidEntityInsertionAdapter;

  final UpdateAdapter<PengaturanAutocodeAndroidEntity>
      _pengaturanAutocodeAndroidEntityUpdateAdapter;

  final DeletionAdapter<PengaturanAutocodeAndroidEntity>
      _pengaturanAutocodeAndroidEntityDeletionAdapter;

  @override
  Future<void> deleteAll() async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM pengaturan_autocode_android');
  }

  @override
  Future<List<PengaturanAutocodeAndroidEntity>>
      getPengaturanAutocodeAndroid() async {
    return _queryAdapter.queryList('SELECT * FROM pengaturan_autocode_android',
        mapper: (Map<String, Object?> row) => PengaturanAutocodeAndroidEntity(
            code: row['code'] as String,
            value: row['value'] as String?,
            count: row['count'] as String?,
            status: row['status'] as int?,
            statusKirim: row['statusKirim'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?));
  }

  @override
  Future<List<PengaturanAutocodeAndroidEntity>> getPengaturanAutocodeAndroidOne(
      String code) async {
    return _queryAdapter.queryList(
        'SELECT * FROM pengaturan_autocode_android WHERE code = ?1',
        mapper: (Map<String, Object?> row) => PengaturanAutocodeAndroidEntity(
            code: row['code'] as String,
            value: row['value'] as String?,
            count: row['count'] as String?,
            status: row['status'] as int?,
            statusKirim: row['statusKirim'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?),
        arguments: [code]);
  }

  @override
  Future<List<PengaturanAutocodeAndroidEntity>>
      getPengaturanAutocodeAndroidByCode(String code) async {
    return _queryAdapter.queryList(
        'SELECT * FROM pengaturan_autocode_android WHERE code LIKE ?1',
        mapper: (Map<String, Object?> row) => PengaturanAutocodeAndroidEntity(
            code: row['code'] as String,
            value: row['value'] as String?,
            count: row['count'] as String?,
            status: row['status'] as int?,
            statusKirim: row['statusKirim'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?),
        arguments: [code]);
  }

  @override
  Future<void> insertEntity(PengaturanAutocodeAndroidEntity model) async {
    await _pengaturanAutocodeAndroidEntityInsertionAdapter.insert(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateEntity(PengaturanAutocodeAndroidEntity model) async {
    await _pengaturanAutocodeAndroidEntityUpdateAdapter.update(
        model, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEntity(PengaturanAutocodeAndroidEntity model) async {
    await _pengaturanAutocodeAndroidEntityDeletionAdapter.delete(model);
  }
}
