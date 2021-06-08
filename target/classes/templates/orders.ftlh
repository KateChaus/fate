<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>

<!--***************************************************************************
************************************ЗАЯВКИ*************************************
****************************************************************************-->
<nav class="navbar navbar-dark bg-dark border-top border-dark">
    <div class="container-fluid">
        <div class="mt-0 bg-dark">
            <div class="d-flex align-items-center">
                <a class="text-light fs-5 nav-link" href="/">Заявки</a>
            </div>
        </div>
    </div>
</nav>

<div class=" d-flex justify-content-center">
<div class="row container">
    <#if applications??>
    <#list applications as application>

    <div class="card border border-secondary bg-dark m-2" style="width: 18rem;">
        <div class="container d-flex justify-content-center pt-0 border-darker mt-2">
            <h5 class="card-title text-light">${application.getName()}</h5>
        </div>

        <div class="card-body mt-0 pt-0 ">
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
                    <form action="order" method="post">
                        <input type="hidden" name="orderApplication" value="${application.getId()}"/>
                    <button type="submit" name="statusChange" value="statusChange" class="btn btn-dark m-0 p-0">
                        <#if application.isOpen()>
                            <i class="bi bi-pause-fill fs-4 p-0 m-0 text-primary"></i>
                        <#else>
                            <i class="bi bi-play-fill fs-4 p-0 m-0 text-success"></i>
                        </#if>
                    </button>
                    <button type="submit" name="edit" value="edit" class="btn btn-dark m-0 px-1">
                        <i class="bi bi-pencil-square text-secondary "></i>
                    </button>
                    <button type="submit" name="delete" value="delete" class="btn btn-dark m-0 px-1">
                        <i class="bi bi-x-square text-danger"></i>
                    </button>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    </form>
                </div>
            </div>
        </div>
    </div>

        </#list>
</#if>
    <div class="card border border-secondary bg-dark m-2" style="width: 18rem;">
        <div class="card-body d-flex align-items-center">
            <a href=
                       <#if artistSearch="true">
                            "customer/new"
                        <#else>
                            "artist/new"
                        </#if>>
                        <img src="/img/plus.png" class="card-img-top" alt="...">
            </a>
        </div>
    </div>
</div>
</div>


<!--***************************************************************************
*******************************ЗАКАЗЫ В ПРОЦЕССЕ*******************************
****************************************************************************-->
<nav class="navbar navbar-dark bg-dark border-top border-dark">
    <div class="container-fluid">
        <div class="mt-0 bg-dark">
            <div class="d-flex align-items-center">
                <a class="text-light fs-5 nav-link" href="/">В процессе</a>
            </div>
        </div>
    </div>
</nav>


<div class=" d-flex justify-content-center">
<div class="row container">

    <#if inProcess??>
    <#list inProcess as order>
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
            <img src="/img/arts/${order.getImage()}" class="card-img-top" alt="...">
            <div class="text-light">
                ${order.getOrderApplication().getDescription()}
            </div>
        </div>
        <div class="card-footer">

            <div class="container d-flex justify-content-between align-items-center px-0">
                <a href="#" class="text-secondary  text-decoration-none">
                    <#if artistSearch="true">
                        ${order.getArtist().getUsername()}
                    <#else>
                        ${order.getCustomer().getUsername()}
                    </#if>
                </a>
                    <form action="/orders/update/${order.getId()}" enctype="multipart/form-data" method="post">

                        <div class="d-flex  justify-content-start ms-0 ">
                            <div class="input-group border-none m-2 p-0">
                                <#if artistSearch="true">
                                    <i class="bi bi-star-fill border-none text-purple mx-1"></i>
                                <#else>
                                    <i class="bi bi-star-fill border-none text-primary mx-1"></i>
                                </#if>
                                <#if artistSearch="false">
                                    <#assign orderRate=order.getCustomerRating()>
                                <#else>
                                    <#assign orderRate=order.getArtistRating()>
                                </#if>
                                <select id="rate" name="rate"  class="btn-dark bg-dark border-none text-light px-1">
                                    <option value="5" <#if orderRate=5>selected</#if>>5</option>
                                    <option value="4" <#if orderRate=4>selected</#if>>4</option>
                                    <option value="3" <#if orderRate=3>selected</#if>>3</option>
                                    <option value="2" <#if orderRate=2>selected</#if>>2</option>
                                    <option value="1" <#if orderRate=1>selected</#if>>1</option>
                                </select>
                            </div>
                            <div class="d-flex  justify-content-start align-items-center ms-0 ">
                                <#if artistSearch="false">
                                <label for="image">
                                    <input type="file" name = "image"  id="image" style="display:none;" onchange="form.submit()">
                                    <i class="bi bi-image text-light  m-0 px-0 mx-0"></i>
                                </label>
                            </#if>
                                <#if order.getStatus()="В процессе">
                                <#if artistSearch="false">

                                <button type="submit" name="status" value="process" class="btn btn-dark  m-0 px-1">
                                    <i class="bi bi-check-lg text-success"></i>
                                </button>
                                </#if>
                                <#else>
                                    <#if artistSearch="false">
                                    <button type="button" name="status" value="confirmed" class="btn btn-dark  m-0 px-1">
                                        <i class="bi bi-check-lg text-secondary"></i>
                                    </button>
                                    <#else>
                                    <button type="submit" name="status" value="completed" class="btn btn-dark  m-0 px-1">
                                        <i class="bi bi-check-lg text-success"></i>
                                    </button>
                                </#if>
                                </#if>

                            </div>
                        </div>

                        <input type="hidden" name="currentImage" value="${order.getImage()}"/>
                        <input type="hidden" name="artistSearch" value="${artistSearch}"/>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    </form>
            </div>
        </div>
    </div>
</#list>
</#if>


</div>
</div>


<!--***************************************************************************
******************************ЗАКАЗЫ ЗАВЕРШЁННЫЕ*******************************
****************************************************************************-->
<nav class="navbar navbar-dark bg-dark border-top border-dark">
    <div class="container-fluid">
        <div class="mt-0 bg-dark">
            <div class="d-flex align-items-center">
                <a class="text-light fs-5 nav-link" href="/">Завершённые</a>
            </div>
        </div>
    </div>
</nav>


<div class=" d-flex justify-content-center">
    <div class="row container">

        <#if confirmed??>
        <#list confirmed as order>
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
                <img src="/img/arts/${order.getImage()}" class="card-img-top" alt="...">
                <div class="text-light">
                    ${order.getOrderApplication().getDescription()}
                </div>
            </div>
            <div class="card-footer">

                <div class="container d-flex justify-content-between align-items-center px-0">
                    <a href="#" class="text-secondary  text-decoration-none">
                        <#if artistSearch="true">
                        ${order.getArtist().getUsername()}
                        <#else>
                        ${order.getCustomer().getUsername()}
                    </#if>
                    </a>
                        <div class="d-flex  justify-content-start ms-0 ">
                            <div class="input-group border-none m-2 p-0">
                                <#if artistSearch="true">
                                <i class="bi bi-star-fill border-none text-purple mx-1"></i>
                                <#else>
                                <i class="bi bi-star-fill border-none text-primary mx-1"></i>
                            </#if>
                            <#if artistSearch="false">
                            <#assign orderRate=order.getCustomerRating()>
                            <#else>
                            <#assign orderRate=order.getArtistRating()>
                            </#if>
                            <select id="rate" name="rate"  class="btn-dark bg-dark border-none text-light px-1">
                                <option value="5" <#if orderRate=5>selected</#if>>5</option>
                                <option value="4" <#if orderRate=4>selected</#if>>4</option>
                                <option value="3" <#if orderRate=3>selected</#if>>3</option>
                                <option value="2" <#if orderRate=2>selected</#if>>2</option>
                                <option value="1" <#if orderRate=1>selected</#if>>1</option>
                            </select>
                        </div>



                        <div class="input-group border-none m-2 p-0">
                            <#if artistSearch="false">
                            <i class="bi bi-star-fill border-none text-purple mx-1"></i>
                            <#else>
                            <i class="bi bi-star-fill border-none text-primary mx-1"></i>
                        </#if>
                        <#if artistSearch="false">
                        <#assign orderRate=order.getArtistRating()>
                        <#else>
                        <#assign orderRate=order.getCustomerRating()>
                        </#if>
                        <select id="rate" name="rate"  class="btn-dark bg-dark border-none text-light px-1">
                            <option value="5" <#if orderRate=5>selected</#if>>5</option>
                        <option value="4" <#if orderRate=4>selected</#if>>4</option>
                        <option value="3" <#if orderRate=3>selected</#if>>3</option>
                        <option value="2" <#if orderRate=2>selected</#if>>2</option>
                        <option value="1" <#if orderRate=1>selected</#if>>1</option>
                        </select>
                        </div>


</div>
</div>

</div>
</div>

</#list>
</#if>

</div>
</div>
</div>

</@c.page>