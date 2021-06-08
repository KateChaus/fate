<#import "parts/common.ftlh" as c>
<@c.page>

<ul class="nav nav-tabs border-bottom border-dark justify-content-center mt-0" id="myTab" role="tablist">
    <li class="nav-item ">
        <button class="nav-link bg-dark mx-2 text-light active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab" aria-controls="home" aria-selected="true">Все типы</button>
    </li>
    <li class="nav-item ">
        <button class="nav-link bg-dark mx-2 text-light" id="tradtional-tab" data-bs-toggle="tab" data-bs-target="#traditional" type="button" role="tab" aria-controls="traditional" aria-selected="false">2D (Традиционный)</button>
    </li>
    <li class="nav-item ">
        <button class="nav-link bg-dark mx-2 text-light" id="digital-tab" data-bs-toggle="tab" data-bs-target="#digital" type="button" role="tab" aria-controls="digital" aria-selected="false">2D (Цифровой)</button>
    </li>
    <li class="nav-item ">
        <button class="nav-link bg-dark mx-2 text-light" id="threed-tab" data-bs-toggle="tab" data-bs-target="#threed" type="button" role="tab" aria-controls="threed" aria-selected="false">3D</button>
    </li>
    <li class="nav-item ">
        <button class="nav-link bg-dark mx-2 text-light" id="animation-tab" data-bs-toggle="tab" data-bs-target="#animation" type="button" role="tab" aria-controls="animation" aria-selected="false">Анимация</button>
    </li>
    <li class="nav-item ">
        <button class="nav-link bg-dark mx-2 text-light" id="other-tab" data-bs-toggle="tab" data-bs-target="#other" type="button" role="tab" aria-controls="other" aria-selected="false">Другое</button>
    </li>
</ul>


<div class="tab-content m-0 p-0" id="myTabContent">
   <div class="tab-pane fade show active text-light m-0 p-0 " id="all" role="tabpanel" aria-labelledby="all-tab">

        <div class=" d-flex justify-content-center  m-0 p-0">
            <div class="row row-cols-5 d-flex justify-content-between p-0 m-0">

                <#if orders??>
                <#list orders as order>
                    <#include "parts/orderCard.ftlh" />
                </#list>
            </#if>
            </div>
        </div>
    </div>

    <div class="tab-pane fade text-light border" id="traditional" role="tabpanel" aria-labelledby="traditional-tab">
        <div class=" d-flex justify-content-center">
            <div class="row row-cols-5 d-flex justify-content-between p-0 m-0">
                <#if orders??>
                    <#list orders as order>
                        <#if order.getOrderApplication().getType()="2D (Традиционный)">
                            <#include "parts/orderCard.ftlh" />
                        </#if>
                    </#list>
                </#if>
            </div>
        </div>
    </div>

    <div class="tab-pane fade text-light border" id="digital" role="tabpanel" aria-labelledby="digital-tab">
        <div class=" d-flex justify-content-center">
            <div class="row row-cols-5 d-flex justify-content-between p-0 m-0">
                <#if orders??>
                    <#list orders as order>
                        <#if order.getOrderApplication().getType()="2D (Цифровой)">
                            <#include "parts/orderCard.ftlh" />
                        </#if>
                    </#list>
                </#if>
            </div>
        </div>
    </div>

    <div class="tab-pane fade text-light" id="threed" role="tabpanel" aria-labelledby="threed-tab">
        <div class=" d-flex justify-content-center">
            <div class="row row-cols-5 d-flex justify-content-between p-0 m-0">
                <#if orders??>
                    <#list orders as order>
                        <#if order.getOrderApplication().getType()="3D">
                            <#include "parts/orderCard.ftlh" />
                        </#if>
                    </#list>
                </#if>
            </div>
        </div>
    </div>

    <div class="tab-pane fade text-light" id="animation" role="tabpanel" aria-labelledby="animation-tab">
        <div class=" d-flex justify-content-center ">
            <div class="row row-cols-5 d-flex justify-content-between p-0 m-0">
                <#if orders??>
                    <#list orders as order>
                        <#if order.getOrderApplication().getType()="Aнимация">
                            <#include "parts/orderCard.ftlh" />
                        </#if>
                    </#list>
                </#if>
            </div>
        </div>
    </div>

    <div class="tab-pane fade text-light" id="other" role="tabpanel" aria-labelledby="other-tab">
        <div class=" d-flex justify-content-center">
            <div class="row row-cols-5 d-flex justify-content-between p-0 m-0">
                <#if orders??>
                    <#list orders as order>
                        <#if order.getOrderApplication().getType()="Другое">
                            <#include "parts/orderCard.ftlh" />
                        </#if>
                    </#list>
                </#if>
            </div>
        </div>
    </div>
</div>


</@c.page>