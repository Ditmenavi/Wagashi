sidebar = $(".sidebar");
menuCont = $(".menu-cont");
submitFaq = $(".submit-faq");
menuCont.click(
    () => {
        if(menuCont.is(":checked")){
            document.body.style.setProperty("--sidebar-width", "200px");
            submitFaq.addClass("submit-faq-extended");
            $(".category-element").css("width", "120px").css("padding", "0 20px");
            $(".category-text").css("transform", "scale(1)").css("width", "fit-content").css("height", "11px").css("padding-left", "10px").addClass("scale-in-left");
        } else {
            document.body.style.setProperty("--sidebar-width", "70px");
            submitFaq.removeClass("submit-faq-extended");
            $(".category-element").css("width", "50px").css("padding", "0");
            $(".category-text").css("transform", "scale(0)").css("width", "0").css("height", "0").css("padding-left", "0px").removeClass("scale-in-left");
        }
    }
)