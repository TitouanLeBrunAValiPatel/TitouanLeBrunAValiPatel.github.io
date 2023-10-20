var actionGroup = `
<div class="devices-headers-table-menu" style="padding:6px 6px 0px 0px;">
                        <div class="actions btn-group"><button class="btn btn-default" type="button" title="Refresh"
                                style="height: 34px;"><span class="icon glyphicon glyphicon-refresh"></span></button>
                            <div class="dropdown btn-group"><button class="btn btn-default dropdown-toggle"
                                    type="button" data-toggle="dropdown"><span class="dropdown-text">50</span> <span
                                        class="caret"></span></button>
                                <ul class="dropdown-menu pull-right" role="menu">
                                    <li class="active" aria-selected="true"><a data-action="50"
                                            class="dropdown-item dropdown-item-button">50</a></li>
                                    <li aria-selected="false"><a data-action="100"
                                            class="dropdown-item dropdown-item-button">100</a></li>
                                    <li aria-selected="false"><a data-action="250"
                                            class="dropdown-item dropdown-item-button">250</a></li>
                                    <li aria-selected="false"><a data-action="-1"
                                            class="dropdown-item dropdown-item-button">All</a></li>
                                </ul>
                            </div>
                            <div class="dropdown btn-group"><button class="btn btn-default dropdown-toggle"
                                    type="button" data-toggle="dropdown"><span class="dropdown-text"><span
                                            class="icon glyphicon glyphicon-th-list"></span></span> <span
                                        class="caret"></span></button>
                                <ul class="dropdown-menu pull-right" role="menu">
                                    <li><label class="dropdown-item"><input name="status" type="checkbox" value="1"
                                                class="dropdown-item-checkbox" checked="checked"> &nbsp;</label></li>
                                    <li><label class="dropdown-item"><input name="icon" type="checkbox" value="1"
                                                class="dropdown-item-checkbox" checked="checked"> Vendor</label></li>
                                    <li><label class="dropdown-item"><input name="hostname" type="checkbox" value="1"
                                                class="dropdown-item-checkbox" checked="checked"> Appareils</label></li>
                                    <li><label class="dropdown-item"><input name="last_polled" type="checkbox" value="1"
                                                class="dropdown-item-checkbox" checked="checked"> Dernier
                                            sondage</label></li>
                                    <li><label class="dropdown-item"><input name="os" type="checkbox" value="1"
                                                class="dropdown-item-checkbox" checked="checked"> Systeme
                                            d'exploitation</label></li>
                                    <li><label class="dropdown-item"><input name="location" type="checkbox" value="1"
                                                class="dropdown-item-checkbox" checked="checked"> Emplacement</label>
                                    </li>
                                    <li><label class="dropdown-item"><input name="actions" type="checkbox" value="1"
                                                class="dropdown-item-checkbox" checked="checked"> Actions</label></li>
                                </ul>
                            </div>
                        </div>
                        <div class="pull-left">
                            <form method="post" action="" class="form-inline devices-search-header" role="form"><input
                                    type="hidden" name="_token" value="bYf6MjGYhPxTOpZPjGjdDQLwEBczDqOuekIbxJYQ">
                                <div class="form-group"><input type="text" name="searchquery" id="searchquery"
                                        value=""  class="form-control" placeholder="Rechercher"></div>
                                <div class="form-group"><select name="state" id="state" class="form-control">
                                        <option value="">Tout</option>
                                        <option value="up">Actif</option>
                                        <option value="down">Injoignable</option>
                                    </select></div>
                                <div class="form-group"><select name="os" id="os"
                                        class="form-control select2-hidden-accessible" tabindex="-1"
                                        aria-hidden="true"></select><span
                                        class="select2 select2-container select2-container--bootstrap" dir="ltr"
                                        style="width: auto;"><span class="selection"><span
                                                class="select2-selection select2-selection--single" role="combobox"
                                                aria-haspopup="true" aria-expanded="false" tabindex="0"
                                                aria-labelledby="select2-os-container"><span
                                                    class="select2-selection__rendered" id="select2-os-container"><span
                                                        class="select2-selection__placeholder">Tous les
                                                        OS</span></span><span class="select2-selection__arrow"
                                                    role="presentation"><b
                                                        role="presentation"></b></span></span></span><span
                                            class="dropdown-wrapper" aria-hidden="true"></span></span></div>
                                <div class="form-group"><select name="version" id="version"
                                        class="form-control select2-hidden-accessible" tabindex="-1"
                                        aria-hidden="true"></select><span
                                        class="select2 select2-container select2-container--bootstrap" dir="ltr"
                                        style="width: auto;"><span class="selection"><span
                                                class="select2-selection select2-selection--single" role="combobox"
                                                aria-haspopup="true" aria-expanded="false" tabindex="0"
                                                aria-labelledby="select2-version-container"><span
                                                    class="select2-selection__rendered"
                                                    id="select2-version-container"><span
                                                        class="select2-selection__placeholder">Toutes les
                                                        versions</span></span><span class="select2-selection__arrow"
                                                    role="presentation"><b
                                                        role="presentation"></b></span></span></span><span
                                            class="dropdown-wrapper" aria-hidden="true"></span></span></div>
                                <div class="form-group"><select name="hardware" id="hardware"
                                        class="form-control select2-hidden-accessible" tabindex="-1"
                                        aria-hidden="true"></select><span
                                        class="select2 select2-container select2-container--bootstrap" dir="ltr"
                                        style="width: auto;"><span class="selection"><span
                                                class="select2-selection select2-selection--single" role="combobox"
                                                aria-haspopup="true" aria-expanded="false" tabindex="0"
                                                aria-labelledby="select2-hardware-container"><span
                                                    class="select2-selection__rendered"
                                                    id="select2-hardware-container"><span
                                                        class="select2-selection__placeholder">Toutes les
                                                        plateformes</span></span><span class="select2-selection__arrow"
                                                    role="presentation"><b
                                                        role="presentation"></b></span></span></span><span
                                            class="dropdown-wrapper" aria-hidden="true"></span></span></div>
                                <div class="form-group"><select name="type" id="device-type"
                                        class="form-control select2-hidden-accessible" tabindex="-1"
                                        aria-hidden="true"></select><span
                                        class="select2 select2-container select2-container--bootstrap" dir="ltr"
                                        style="width: auto;"><span class="selection"><span
                                                class="select2-selection select2-selection--single" role="combobox"
                                                aria-haspopup="true" aria-expanded="false" tabindex="0"
                                                aria-labelledby="select2-device-type-container"><span
                                                    class="select2-selection__rendered"
                                                    id="select2-device-type-container"><span
                                                        class="select2-selection__placeholder">Tous les
                                                        types</span></span><span class="select2-selection__arrow"
                                                    role="presentation"><b
                                                        role="presentation"></b></span></span></span><span
                                            class="dropdown-wrapper" aria-hidden="true"></span></span>
                                            
                                </div>
                                
                                            
                                            
                                            <input
                                    type="submit" class="btn btn-info" value="Rechercher"><a
                                    href="http://scoop-test.yogoko.fr/devices/format=list_detail/"
                                    title="Update the browser URL to reflect the search criteria."
                                    class="btn btn-default">Mettre a jour l'URL</a><a
                                    href="http://scoop-test.yogoko.fr/devices/" title="Reset criteria to default."
                                    class="btn btn-default">Reinitialiser</a>



                                <div class="form-group" id="updateSelectTagVisibility">
                                        <select class="form-control" id="selectGroup">


                                    </select>
                                    <button type="button" onclick="updateRowVisibility('tous')" class="btn btn-info">Effacer le filtre</button>
                                </div>   
                            </form>
                        </div>
                
`;
document.getElementById('actionGroup').insertAdjacentHTML('afterbegin', actionGroup);