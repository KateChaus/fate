<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>

<form method="post" class="ms-5">
    <div>
        <div class="container-fluid mb-4 ms-2">
            <h2 class="text-light">${userChannel.getUsername()} - заявка художника</h2>
        </div>
        <div class="d-flex justify-content-start ms-2 col-5">
            <div class="input-group mb-3">
            <span class="input-group-text bg-dark text-light col-4">
                Название
            </span>
                <input type="text"
                       class="form-control bg-dark text-light"
                       name="name"
                       value="${orderApplication.getName()}"
                />
            </div>
        </div>

        <div class="d-flex justify-content-start ms-2 col-5">
            <div class="input-group mb-3">
                <span class="input-group-text bg-dark text-secondary col-4">
                Стоимость
                </span>
                <input type="text"
                       class="form-control bg-dark text-secondary"
                       name="cost"
                       value="${orderApplication.getCost()}"
                       disabled readonly
                />
            </div>
        </div>

        <div class="d-flex justify-content-start ms-2 col-5">
            <div class="input-group mb-3">
                <span class="input-group-text bg-dark text-secondary col-4">Стиль</span>
                <input type="text"
                       class="form-control bg-dark text-secondary"
                       name="type"
                       value = "${orderApplication.getType()}"
                       disabled readonly
                />
            </div>
        </div>

        <div class="container p-0 ms-2 col-5">
            <h5 class="text-light">Описание</h5>
            <div class="input-group mt-3">
                <textarea class="form-control border-secondary bg-dark text-light" name="description" rows="5" style="height:100%;">${orderApplication.getDescription()}</textarea>
            </div>
        </div>

    </div>
    <div class="d-flex justify-content-start">
        <button type="submit" class="btn btn-secondary ms-2 mt-3" type="button">Изменить</button>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>
</@c.page>