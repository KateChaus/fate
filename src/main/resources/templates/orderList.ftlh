<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>


<#if customer>
<nav class="navbar border-top border-secondary navbar-dark bg-dark mt-5">
    <div class="container-fluid">
        <div class="mt-0 bg-dark">
            <div class="d-flex align-items-center">
                <a class="text-light fs-5 nav-link" href="/">Последние заказы</a>
            </div>
        </div>
    </div>
</nav>
<#else>
<nav class="navbar border-top border-secondary navbar-dark bg-dark mt-5">
    <div class="container-fluid">
        <div class="mt-0 bg-dark">
            <div class="d-flex align-items-center">
                <a class="text-light fs-5 nav-link" href="/">Последние работы</a>
            </div>
        </div>
    </div>
</nav>
</#if>
<div class=" d-flex justify-content-center  m-0 p-0">
    <div class="row row-cols-5 d-flex justify-content-between p-0 m-0">
<#if orders??>
<#list orders as order>
<div class="card border border-secondary bg-dark m-2" style="width: 18rem;">
    <div class="container d-flex justify-content-center mt-2">
        <h5 class="card-title text-light mb-0">${order.getOrderApplication().getName()}</h5>
    </div>
    <div class="card-body">
        <img src="/img/arts/${order.getImage()}" class="card-img-top" alt="...">
        <div class="container d-flex justify-content-between px-0">
            <a href="#" class=" text-light text-decoration-none">
                <#if !customer>
                    ${order.getCustomer().getUsername()}
                <#else>
                    ${order.getArtist().getUsername()}
                </#if>
            </a>
            <div class="d-flex  justify-content-start  ms-0 my-0 py-0">
                <div class="input-group border-none m-2 p-0  my-0">
                    <#if !customer>
                        <i class="bi bi-star-fill border-none text-purple mx-1 py-0 my-0"></i>
                        <span class="text-light">${order.getArtistRating()}</span>
                    <#else>
                        <i class="bi bi-star-fill border-none text-purple mx-1 py-0 my-0"></i>
                        <span class="text-light">${order.getArtistRating()}</span>
                    </#if>
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