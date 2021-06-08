<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>

<ul class="nav nav-tabs ms-4 me-5" id="myTab" role="tablist">
    <li class="nav-item ">
        <button class="nav-link bg-dark text-light active" id="artists-tab" data-bs-toggle="tab" data-bs-target="#artists" type="button" role="tab" aria-controls="home" aria-selected="true">Поиск художника</button>
    </li>
    <li class="nav-item ">
        <button class="nav-link bg-dark text-light" id="customers-tab" data-bs-toggle="tab" data-bs-target="#customers" type="button" role="tab" aria-controls="profile" aria-selected="false">Поиск заказчика</button>
    </li>
</ul>




<div class="tab-content" id="myTabContent">


    <div class="tab-pane fade show active text-light" id="artists" role="tabpanel" aria-labelledby="home-tab">


        <button class="btn btn-secondary hide-me ms-5 mt-3 mb-2" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample"  aria-controls="collapseExample">
            Фильтр<i class="bi bi-chevron-double-right"></i>
        </button>
        <div class="collapse mx-5" id="collapseExample">
            <div class="card card-body bg-dark me-4">
                <form method="get">
                    <div class="d-flex justify-content-start ms-2 ">
                        <div class="input-group mb-3 me-2">
                            <span class="input-group-text bg-dark text-light col-4">Стиль</span>
                            <select id="type" name="type" class="form-select bg-dark text-light ">
                                <option value="none">-</option>
                                <option value="traditional">2D (Традиционный)</option>
                                <option value="digital">2D (Цифровой)</option>
                                <option value="threedimensional">3D</option>
                                <option value="animation">Анимация</option>
                                <option value="other">Другое</option>
                            </select>
                        </div>
                        <div class="input-group mb-3 ms-2">
                <span class="input-group-text bg-dark text-light col-4">
                Стоимость до
                </span>
                            <input type="text"
                                   class="form-control bg-dark text-light"
                                   name="cost"
                            />
                        </div>
                    </div>
                    <div class="d-flex justify-content-between">
                        <button class="btn btn-secondary ms-2" type="submit">Показать</button>
                        <button class="btn btn-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample"  aria-controls="collapseExample">
                            <i class="bi bi-chevron-double-up text-light"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>



        <div class = "container d-flex justify-content-center ">
            <div class="row container">
                <#if artistApplications??>
                <#list artistApplications as application>

                <div class="card border border-secondary bg-dark m-2" style="width: 18rem;">
                    <div class="container d-flex justify-content-left p-0 border-darker mt-2">
                        <i class="bi bi-star-fill text-primary mx-1"></i><h5 class="card-title text-light">${application.getName()}</h5>
                    </div>

                    <div class="card-body mt-1 pt-0 ">
                        <div class="container d-flex justify-content-between align-items-center mt-0 p-0 my-1">
                <span href="#" class="text-light text-decoration-none mt-0">
                    ${application.getType()}
                </span>
                            <span href="#" class="text-light text-decoration-none mt-0">
                    $${application.getCost()}
                </span>
                        </div>
                        <div class="text-light">
                            ${application.getDescription()}
                        </div>
                    </div>
                    <div class="card-footer">

                        <div class="container d-flex justify-content-between align-items-center px-0">
                            <a href="#" class="text-secondary text-decoration-none">
                                #${application.getId()}
                            </a>
                            <div class="m-0 p-0">
                                <form action="/orders/${application.getId()}/apply" method="post">
                                    <input type="hidden" name="orderApplication" value="${application.getId()}"/>
                                    <a name="artist" value="edit" class="btn btn-dark m-0 px-1" href="/user/${application.getCreator().getId()}/profile">
                                        <i class="bi bi-person-fill text-light">  ${application.getCreator().getUsername()}</i>
                                    </a>
                                    <#if userChannel.getId()!=application.getCreator().getId()>
                                    <button type="submit" name="apply" value="delete" class="btn btn-dark m-0 px-1">
                                        <i class="bi bi-check-lg text-success"></i>
                                    </button>
                                    </#if>
                                <input type="hidden" name="application" value = "${application.getId()}">

                                <input type="hidden" name="artistSearch" value = "true">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </#list>
        </#if>
    </div>
</div>

    </div>



    <div class="tab-pane fade text-light" id="customers" role="tabpanel" aria-labelledby="profile-tab">


        <button class="btn btn-secondary hide-me ms-5 mt-3 mb-2" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample"  aria-controls="collapseExample">
            Фильтр<i class="bi bi-chevron-double-right"></i>
        </button>
        <div class="collapse mx-5" id="collapseExample">
            <div class="card card-body bg-dark me-4">
                <form method="get">
                    <div class="d-flex justify-content-start ms-2 ">
                        <div class="input-group mb-3 me-2">
                            <span class="input-group-text bg-dark text-light col-4">Стиль</span>
                            <select id="type" name="type" class="form-select bg-dark text-light ">
                                <option value="none">-</option>
                                <option value="traditional">2D (Традиционный)</option>
                                <option value="digital">2D (Цифровой)</option>
                                <option value="threedimensional">3D</option>
                                <option value="animation">Анимация</option>
                                <option value="other">Другое</option>
                            </select>
                        </div>
                        <div class="input-group mb-3 ms-2">
                <span class="input-group-text bg-dark text-light col-4">
                Стоимость до
                </span>
                            <input type="text"
                                   class="form-control bg-dark text-light"
                                   name="cost"
                            />
                        </div>
                    </div>
                    <div class="d-flex justify-content-between">
                        <button class="btn btn-secondary ms-2" type="submit">Показать</button>
                        <button class="btn btn-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample"  aria-controls="collapseExample">
                            <i class="bi bi-chevron-double-up text-light"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>



        <div class = "container d-flex justify-content-center ">
            <div class="row container">
                <#if customerApplications??>
                <#list customerApplications as application>

                <div class="card border border-secondary bg-dark m-2" style="width: 18rem;">
                    <div class="container d-flex justify-content-left p-0 border-darker mt-2">
                        <i class="bi bi-star-fill text-purple mx-1"> </i><h5 class="card-title text-light">${application.getName()}</h5>
                    </div>

                    <div class="card-body mt-1 pt-0 ">
                        <div class="container d-flex justify-content-between align-items-center mt-0 p-0 my-1">
                <span href="#" class="text-light text-decoration-none mt-0">
                    ${application.getType()}
                </span>
                            <span href="#" class="text-light text-decoration-none mt-0">
                    $${application.getCost()}
                </span>
                        </div>
                        <div class="text-light">
                            ${application.getDescription()}
                        </div>
                    </div>
                    <div class="card-footer">

                        <div class="container d-flex justify-content-between align-items-center px-0">
                            <a href="#" class="text-secondary text-decoration-none">
                                #${application.getId()}
                            </a>
                            <div class="m-0 p-0">
                                <form action="/orders/${application.getId()}/apply" method="post">
                                    <input type="hidden" name="orderApplication" value="${application.getId()}"/>
                                    <a name="artist" value="edit" class="btn btn-dark m-0 px-1" href="/user/${application.getCreator().getId()}/profile">
                                        <i class="bi bi-person-fill text-light">  ${application.getCreator().getUsername()}</i>
                                    </a>
                                    <#if userChannel.getId()!=application.getCreator().getId()>

                                    <button type="submit" name="apply" value="delete" class="btn btn-dark m-0 px-1">
                                        <i class="bi bi-check-lg text-success"></i>
                                    </button>
                                    </#if>
                                    <input type="hidden" name="application" value = "${application.getId()}">
                                    <input type="hidden" name="artistSearch" value = "false">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </#list>
        </#if>
    </div>
</div>

    </div>

</div>




</@c.page>