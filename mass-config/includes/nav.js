const body = document.body
const navi = `
<div class="pace  pace-inactive">
<div class="pace-progress" style="transform: translate3d(100%, 0px, 0px);" data-progress-text="100%"
    data-progress="99">
    <div class="pace-progress-inner"></div>
</div>
<div class="pace-activity"></div>
</div>
<nav class="navbar navbar-default  navbar-fixed-top" role="navigation">
<div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navHeaderCollapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="hidden-md hidden-sm navbar-brand" href="./index.html">
            <img src="http://scoop-test.yogoko.fr/images/librenms_logo_light.svg" alt="">
        </a>
    </div>

    <div class="collapse navbar-collapse" id="navHeaderCollapse">
        <ul class="nav navbar-nav">

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-hover="dropdown"
                    data-toggle="dropdown"><i class="fa fa-home fa-fw fa-lg fa-nav-icons hidden-md"
                        aria-hidden="true"></i> <span class="hidden-sm">Vue d'ensemble</span></a>
                <ul class="dropdown-menu multi-level" role="menu">
                    <li><a href="index.html"><i class="fa fa-tv fa-fw fa-lg"
                                aria-hidden="true"></i> Tableau de bord</a></li>
                    
                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-hover="dropdown"
                    data-toggle="dropdown"><i class="fa fa-server fa-fw fa-lg fa-nav-icons hidden-md"
                        aria-hidden="true"></i> <span class="hidden-sm">Appareils</span></a>
                <ul class="dropdown-menu">

                    <li class="dropdown">
                        <a href="#"><i class="fa fa-server fa-fw fa-lg"
                                aria-hidden="true"></i> Tous les appareils</a>
                    </li>

                    <li class="dropdown-submenu"><a><i class="fa fa-th fa-fw fa-lg" aria-hidden="true"></i>
                            Groupes de périphériques </a>
                        <ul class="dropdown-menu scrollable-menu">
                            <li><a href="#" title=""><i
                                        class="fa fa-th fa-fw fa-lg" aria-hidden="true"></i> CD 22</a></li>
                            <li><a href="#" title=""><i
                                        class="fa fa-th fa-fw fa-lg" aria-hidden="true"></i> CD 35</a></li>
                            <li><a href="#" title=""><i
                                        class="fa fa-th fa-fw fa-lg" aria-hidden="true"></i> DIR Ouest</a></li>
                            <li><a href="#" title=""><i
                                        class="fa fa-th fa-fw fa-lg" aria-hidden="true"></i> Région Bretagne</a>
                            </li>
                            <li><a href="#" title=""><i
                                        class="fa fa-th fa-fw fa-lg" aria-hidden="true"></i> Saint-Brieuc
                                    Agglomération</a></li>
                            <li><a href="#" title=""><i
                                        class="fa fa-th fa-fw fa-lg" aria-hidden="true"></i> Test</a></li>
                            <li><a href="#" title=""><i
                                        class="fa fa-th fa-fw fa-lg" aria-hidden="true"></i> Tous</a></li>
                        </ul>
                    </li>


                    <li><a href="#"><i class="fa fa-th fa-fw fa-lg"
                                aria-hidden="true"></i> Gérer les groupes </a></li>

                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-hover="dropdown"
                    data-toggle="dropdown"><i class="fa fa-heartbeat fa-fw fa-lg fa-nav-icons hidden-md"
                        aria-hidden="true"></i> <span class="hidden-sm">Santé</span></a>
                <ul class="dropdown-menu">
                    <li><a href="#"><i
                                class="fa fa-braille fa-fw fa-lg" aria-hidden="true"></i> Mémoire</a>
                    </li>
                    <li><a href="#"><i
                                class="fa fa-microchip fa-fw fa-lg" aria-hidden="true"></i> Processeur </a></li>
                    <li><a href="#"><i
                                class="fa fa-database fa-fw fa-lg" aria-hidden="true"></i> Stockage</a>
                    </li>


                </ul>
            </li>

            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown"><i
                        class="fa fa-exclamation-circle fa-col-danger fa-fw fa-lg fa-nav-icons hidden-md"
                        aria-hidden="true"></i> <span class="hidden-sm">Alertes</span></a>
                <ul class="dropdown-menu">
                    <li><a href="#"><i class="fa fa-bell fa-fw fa-lg"
                                aria-hidden="true"></i> Alertes en cours</a></li>
                    <li><a href="#"><i class="fa fa-file-text fa-fw fa-lg"
                                aria-hidden="true"></i> Historique d'alertes</a></li>
                    <li><a href="#"><i class="fa fa-bar-chart fa-fw fa-lg"
                                aria-hidden="true"></i> Statistiques</a></li>
                    <li role="presentation" class="divider"></li>
                    <li><a href="#"><i class="fa fa-list fa-fw fa-lg"
                                aria-hidden="true"></i> Règles d'alerte</a></li>
                    <li><a href="#"><i
                                class="fa fa-calendar fa-fw fa-lg" aria-hidden="true"></i> Maintenance prévue
                        </a></li>
                    <li><a href="#"><i class="fa fa-file fa-fw fa-lg"
                                aria-hidden="true"></i> Modèles d'alerte</a>
                    </li>
                    <li><a href="#"><i class="fa fa-bus fa-fw fa-lg"
                                aria-hidden="true"></i> Alerte transports </a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-hover="dropdown"><i aria-hidden="true" class="fa fa-cogs fa-col fa-fw fa-lg fa-nav-icons hidden-md"></i> <span class="hidden-sm">Configuration</span></a>
                <ul class="dropdown-menu">
                <li><a href="./templates_tab.html"><i class="fa fa-th fa-fw fa-lg"
                            aria-hidden="true"></i>Gestions des templates</a></li>
                <li><a href="./templates_devices.html"><i class="fa fa-th fa-fw fa-lg"
                aria-hidden="true"></i>Gestion des configurations des appareils</a></li>
            </ul>
                </li>
        </ul>


        <form role="search" class="navbar-form navbar-right global-search">
            <input type="hidden" name="_token" value="WaSIyj331IbqZUCaMkZEN2uK420BohQ9mBSwrylX">
            <div class="form-group">
                <span class="twitter-typeahead" style="position: relative; display: inline-block;"><input
                        class="form-control typeahead tt-hint" type="search" autocomplete="off"
                        style="position: absolute; top: 0px; left: 0px; border-color: transparent; box-shadow: none; opacity: 1; background: rgb(255, 255, 255);"
                        readonly="" spellcheck="false" tabindex="-1" dir="ltr"><input
                        class="form-control typeahead tt-input" type="search" id="gsearch" name="gsearch"
                        placeholder="Recherche Globale" autocomplete="off" spellcheck="false" dir="auto"
                        style="position: relative; vertical-align: top; background-color: transparent;"
                        aria-activedescendant="" aria-owns="gsearch_listbox" role="combobox"
                        aria-readonly="true" aria-autocomplete="list"><span role="status" aria-live="polite"
                        style="position: absolute; padding: 0px; border: 0px; height: 1px; width: 1px; margin-bottom: -1px; margin-right: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap;"></span>
                    <pre aria-hidden="true"
                        style="position: absolute; visibility: hidden; white-space: pre; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; word-spacing: 0px; letter-spacing: 0px; text-indent: 0px; text-rendering: optimizelegibility; text-transform: none;"></pre>
                    <div role="listbox" class=""
                        style="position: absolute; top: 100%; left: 0px; z-index: 100; display: none;">
                        <div role="presentation" class="tt-dataset tt-dataset-0"></div>
                        <div role="presentation" class="tt-dataset tt-dataset-1"></div>
                        <div role="presentation" class="tt-dataset tt-dataset-2"></div>
                    </div>
                </span>
            </div>
        </form>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">
                    <i class="fa fa-user fa-fw fa-lg fa-nav-icons" aria-hidden="true"></i>
                    <span class="badge badge-navbar-user count-notif badge-default"></span>
                    <span class="hidden-sm"><small>admin</small></span>
                    <span class="visible-xs-inline-block">Utilisateur</span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#"><i class="fa fa-cog fa-fw fa-lg"
                                aria-hidden="true"></i> Mes Paramètres</a></li>
                    <li><a href="#"><span
                                class="badge count-notif">0</span> Alertes en cours </a></li>
                    <li role="presentation" class="divider"></li>
                    <li>
                        <a href="#"
                            >
                            <i class="fa fa-sign-out fa-fw fa-lg" aria-hidden="true"></i> Déconnexion </a>

                        <form id="logout-form" action="#" method="POST"
                            style="display: none;">
                            <input type="hidden" name="_token" value="WaSIyj331IbqZUCaMkZEN2uK420BohQ9mBSwrylX">
                        </form>
                    </li>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown" style="margin-top: 4px;">
                    <i class="hidden-sm fa fa-cog fa-fw fa-lg fa-nav-icons" aria-hidden="true"></i>
                    <span class="visible-xs-inline-block">Paramètre</span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#"><i class="fa fa-cogs fa-fw fa-lg"
                                aria-hidden="true"></i> Paramètres globaux</a></li>
                    <li><a href="#"><i class="fa fa-check-circle fa-fw fa-lg"
                                aria-hidden="true"></i> Valider la configuration</a></li>
                    <li role="presentation" class="divider"></li>
                    <li><a href="#"><i class="fa fa-user-circle-o fa-fw fa-lg"
                                aria-hidden="true"></i> Gestion des utilisateurs</a>
                    </li>
                    <li><a href="#"><i class="fa fa-shield fa-fw fa-lg"
                                aria-hidden="true"></i> Historique d'authentification</a></li>
                    <li role="presentation" class="divider"></li>
                    <li class="dropdown-submenu">
                        <a href="#"><i class="fa fa-th-large fa-fw fa-lg"
                                aria-hidden="true"></i> Sondeurs</a>
                        <ul class="dropdown-menu">
                            <li><a href="#"><i
                                        class="fa fa-th-large fa-fw fa-lg" aria-hidden="true"></i> Sondeurs</a>
                            </li>
                            <li><a href="#"><i
                                        class="fa fa-th-large fa-fw fa-lg" aria-hidden="true"></i>
                                    Performance</a></li>
                            <li><a href="#"><i
                                        class="fa fa-file-text fa-fw fa-lg" aria-hidden="true"></i>
                                    Historique</a></li>
                        </ul>
                    </li>
                    <li role="presentation" class="divider"></li>
                    <li class="dropdown-submenu">
                        <a href="#"><i class="fa fa-code fa-fw fa-lg" aria-hidden="true"></i> API</a>
                        <ul class="dropdown-menu">
                            <li><a href="#"><i
                                        class="fa fa-cog fa-fw fa-lg" aria-hidden="true"></i> Paramètres de
                                    l'API </a></li>
                            <li><a href="#" target="_blank" rel="noopener"><i
                                        class="fa fa-book fa-fw fa-lg" aria-hidden="true"></i> Documentation
                                    API</a>
                            </li>
                        </ul>
                    </li>
                    <li role="presentation" class="divider"></li>
                    <li class="dropdown-submenu">
                        <a href="#"><span class="countdown_timer" id="countdown_timer">Refresh
                                disabled</span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#"><span class="countdown_timer_status" id="countdown_timer_status"><i
                                            class="fa fa-pause fa-fw fa-lg"></i></span></a></li>
                        </ul>
                    </li>
                    <li role="presentation" class="divider"></li>
                    <li><a href="#"><i class="fa fa-info-circle fa-fw fa-lg"
                                aria-hidden="true"></i> À propos </a></li>
                </ul>
            </li>

        </ul>
    </div>
</div>
</nav>`;

body.insertAdjacentHTML("afterbegin", navi);