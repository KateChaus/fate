<div class="col <#if user??>col-4<#else>col-3</#if>">
<div class="card border border-secondary bg-dark m-2" style="width: 18rem;">
    <div class="container d-flex justify-content-center pt-0 border-darker mt-2">
        <h5 class="card-title text-light">${order.getOrderApplication().getName()}</h5>
    </div>

    <div class="card-body mt-0 pt-0 ">
        <div class="container d-flex justify-content-between align-items-center mt-0 p-0 my-1">
            <span href="#" class="text-light text-decoration-none mt-0">
                ${order.getOrderApplication().getType()}
            </span>
            <span href="#" class="text-light text-decoration-none mt-0">
                        $${order.getOrderApplication().getCost()}
            </span>
        </div>
        <img src="/img/arts/${order.getImage()}" class="card-img-top" alt="..."/>
        <div class="text-light">
            ${order.getOrderApplication().getDescription()}
        </div>
    </div>

    <div class="card-footer">
        <div class="container d-flex justify-content-between align-items-center  px-0 py-0 my-0">
            <a href="/user/${order.getArtist().getId()}/profile" class="text-secondary py-0 my-0 text-decoration-none ">
                Художник: ${order.getArtist().getUsername()}
            </a>
            <div class="d-flex justify-content-start  ms-0 my-0 py-0">
                <div class="input-group border-none m-2 p-0  my-0">
                    <i class="bi bi-star-fill border-none text-purple mx-1 py-0 my-0"></i>
                    <span class="text-light">${order.getArtistRating()}</span>
                </div>
            </div>
        </div>
        <div class="container d-flex justify-content-between align-items-center px-0 py-0 my-0">
            <a href="/user/${order.getCustomer().getId()}/profile" class="text-secondary py-0 my-0 text-decoration-none">
                Заказчик: ${order.getCustomer().getUsername()}
            </a>
            <div class="d-flex  justify-content-start ms-0 py-0 my-0 ">
                <div class="input-group border-none m-2 p-0 my-0">
                    <i class="bi bi-star-fill border-none text-primary mx-1 py-0 my-0"></i>
                    <span class="text-light">${order.getCustomerRating()}</span>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
