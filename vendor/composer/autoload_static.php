<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInitfdcf36a5b92341aaeb949ff80bd0a06b
{
    public static $prefixLengthsPsr4 = array (
        'D' => 
        array (
            'Database\\Seeders\\' => 17,
            'Database\\Factories\\' => 19,
        ),
        'A' => 
        array (
            'App\\' => 4,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Database\\Seeders\\' => 
        array (
            0 => __DIR__ . '/..' . '/laravel/pint/database/seeders',
        ),
        'Database\\Factories\\' => 
        array (
            0 => __DIR__ . '/..' . '/laravel/pint/database/factories',
        ),
        'App\\' => 
        array (
            0 => __DIR__ . '/..' . '/laravel/pint/app',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInitfdcf36a5b92341aaeb949ff80bd0a06b::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInitfdcf36a5b92341aaeb949ff80bd0a06b::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInitfdcf36a5b92341aaeb949ff80bd0a06b::$classMap;

        }, null, ClassLoader::class);
    }
}
