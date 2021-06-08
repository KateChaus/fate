<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>

    <div class="container d-flex justify-content-center">
        <img src="/img/avatars/${userChannel.getAvatar()}" class="rounded-circle profile col-2" alt="Аватар"/>
    </div>

    <div class="border border-3 border-secondary rounded mt-10">
        <div class=" container d-flex justify-content-center">
            <h2 class="text-light mt-10 mb-0">${userChannel.getUsername()}</h2>
        </div>
        <div class=" container d-flex justify-content-center align-items-center mb-0">
            <i class="text-light fs-5 bi bi-people-fill mx-2"></i>
            <span class="text-light fs-5 mt-1 mx-2">${subscribers}</span>
            <span class="text-light fs-5 mt-1 mx-2">${subscriptions}</span>
             <#if !(userChannel.getId() = currentUser.getId())>
                <#if !isSubscriber>
                    <a href = "/user/subscribe/${userChannel.id}">
                        <i class="text-light fs-5 mt-1 mx-2 bi bi-person-plus-fill"></i>
                    </a>
                <#else>
                    <a href = "/user/unsubscribe/${userChannel.id}">
                        <i class="text-light fs-5 mt-1 mx-2 bi bi-person-dash-fill"></i>
                    </a>
                </#if>
            </#if>
        </div>
        <div class=" container d-flex justify-content-center align-items-center">
            <span class="text-primary fs-1 me-1">★</span>
            <span class="text-light fs-5 mt-1">
                <#if customerRate=0>
                    -
                <#else>
                    ${customerRate}
                </#if>
            </span>
            <#if userChannel.isArtist()>
            <span class="text-purple fs-1 ms-3 me-1">★</span>
            <span class="text-light fs-5 mt-1">
                <#if artistRate=0>
                    -
                <#else>
                    ${artistRate}
                </#if>
            </span>
            </#if>
        </div>

        <#if sites??>
            <div class=" container d-flex justify-content-center fs-5 text-light">
                •
                <#list sites as site>
                    <a class="text-light text-decoration-none me-2 ms-2" href="${site.getSiteAddress()}">
                        ${site.getSiteName()}
                    </a>
                    •
                </#list>
            </div>
        </#if>

        <#if userChannel.getUserInfo()??>
        <div class=" container d-flex justify-content-center fs-5 text-light">
            <p class="text-center">${userChannel.getUserInfo()}</p>
        </div>
        </#if>

<#if userChannel.isArtist()>

        <nav class="navbar navbar-dark bg-dark border-top border-secondary mt-5">
            <div class="container-fluid">
                <div class="mt-0 bg-dark">
                    <div class="d-flex align-items-center">
                        <a class="text-light fs-5 nav-link" href="/">Последние работы</a>
                    </div>
                </div>
                <div class="d-flex ms-auto me-3">
                    <a class="btn btn-dark" href="/user/${userChannel.getId()}/profile/orderList"><i class=" text-light bi bi-chevron-double-right"></i></a>
                </div>
            </div>
        </nav>


        <div class="row mx-2">
            <#if recentOrdersArtist??>
                <#list recentOrdersArtist as order>
                    <div class="card border border-secondary bg-dark m-2" style="width: 18rem;">
                        <div class="container d-flex justify-content-center mt-2">
                            <h5 class="card-title text-light mb-0">${order.getOrderApplication().getName()}</h5>
                        </div>
                        <div class="card-body">
                            <img src="/img/arts/${order.getImage()}" class="card-img-top" alt="...">
                            <div class="container d-flex justify-content-between px-0">
                                <a href="/user/${order.getCustomer().getId()}/profile" class=" text-light text-decoration-none">
                                    ${order.getCustomer().getUsername()}
                                </a>
                                <div class="d-flex  justify-content-start  ms-0 my-0 py-0">
                                    <div class="input-group border-none m-2 p-0  my-0">
                                        <i class="bi bi-star-fill border-none text-purple mx-1 py-0 my-0"></i>
                                        <span class="text-light">${order.getArtistRating()}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
            </#if>
        </div>
</#if>

        <nav class="navbar border-top border-secondary navbar-dark bg-dark mt-5">
            <div class="container-fluid">
                <div class="mt-0 bg-dark">
                    <div class="d-flex align-items-center">
                        <a class="text-light fs-5 nav-link" href="/">Последние заказы</a>
                    </div>
                </div>
                <div class="d-flex ms-auto me-3">
                    <a class="btn btn-dark" href="/user/${userChannel.getId()}/profile/customerList">
                        <i class=" text-light bi bi-chevron-double-right"></i>
                    </a>
                </div>
            </div>
        </nav>


        <div class="row mx-2">
            <#if recentOrdersCustomer??>
                <#list recentOrdersCustomer as order>
                    <div class="card border border-secondary bg-dark m-2" style="width: 18rem;">
                        <div class="container d-flex justify-content-center mt-2">
                            <h5 class="card-title text-light mb-0">${order.getOrderApplication().getName()}</h5>
                        </div>
                        <div class="card-body">
                            <img src="/img/arts/${order.getImage()}" class="card-img-top" alt="...">
                            <div class="container d-flex justify-content-between px-0">
                                <a href="/user/${order.getArtist().getId()}/profile" class=" text-light text-decoration-none">
                                    ${order.getArtist().getUsername()}
                                </a>
                                <div class="d-flex  justify-content-start  ms-0 my-0 py-0">
                                    <div class="input-group border-none m-2 p-0  my-0">
                                        <i class="bi bi-star-fill border-none text-primary mx-1 py-0 my-0"></i>
                                        <span class="text-light">${order.getCustomerRating()}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
            </#if>
        </div>
    </div>


</@c.page>