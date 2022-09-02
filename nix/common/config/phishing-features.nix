{
  inputs,
  cell,
}: let
  inherit (inputs.nixpkgs) lib;
  # https://github.com/tensorflow/tfjs-examples/blob/master/website-phishing/README.md
  thesis = [
    "http://eprints.hud.ac.uk/id/eprint/24330/6/MohammadPhishing14July2015.pdf"
    "http://www.infocomm-journal.com/cjnis/article/2017/2096-109x/2096-109x-3-7-00007.shtml"
    "https://medium.com/nerd-for-tech/url-feature-engineering-and-classification-66c0512fb34d"
    "https://iopscience.iop.org/article/10.1088/1742-6596/1140/1/012048/pdf"
    "https://arxiv.org/pdf/1903.05675.pdf"
  ];
  notebooks = [
    "https://notebook.community/georgetown-analytics/machine-learning/examples/jstyczynski/Phishing%20Website%20Classification%20Analysis"
  ];
in
  builtins.mapAttrs (
    n: v:
      lib.recursiveUpdate v {
        schemas.result = {
          validation = {
            type = "integer";
          };
          example = 0;
        };
      }
  ) {
    having_ip_address = {
      schemas.data = {
        validation.type = "boolean";
        example = false;
      };
      schemas.result.rule = {
        "0" = "otherwise";
        "1" = "if IP address is present, or domain Part has an IP Address → Phishing";
      };
      description = ''
        This is generally an indicator of attempts to collect personal data,
        as many phishing websites employ this trick. All the websites employing
        this trick present in the dataset are associated with phishing websites.

        If the IP address is used as the domain of the URL, such as
        http://125.98.2.142/contoh.html, it can be suspected that attempts to steal information.
        The IP address can also be converted into hexadecimal code.
      '';
    };
    url_length = {
      schemas.data = {
        validation.type = "integer";
        example = 100;
      };
      schemas.result.rule = {
        "0" = "if URL Length < 54 → Legitimate";
        "-1" = "if 54 ≤ URL Length ≤ 75  → suspicious";
        "1" = "otherwise → Phishing";
      };
      description = ''
        Phishing websites often hide suspicious parts of their URLs at the
        end of long URLs which redirect the information submitted by users
        or redirect the web page itself. A length of 54 characters has been
        suggested in previous research [27] to separate phishing websites from legitimate ones.

        Long URLs can also be suspected of being a phishing site like this one:
        http://mencobasitus.com.nr/4c/rea/4b53e4i6f913e51234hfyg46f363r734/?cmd=_home&
        dispatch=1212325vdvtyvwtew5wtetuyuijba5672uh2bi2822gy267gehh74y7@phishing.
        website.html. If the URL length greater than or equal to 54 characters then the URL
        included as a phishing site.
      '';
    };
    shortening_service = {
      schemas.data = {
        validation.type = "string";
        example = "<TinyURL>";
      };
      schemas.result.rule = {
        "0" = "Otherwise → Legitimate";
        "1" = "TinyURL → Phishing";
      };
      description = ''
        Whehter usu the https://zapier.com/blog/best-url-shorteners/ service

        URL shortening is a method in which a URL is made to be shorter, which this domain
        will connect to the web page that has a URL that is longer such, http://sekolah.ini.ac.id/
        URLs can be shortened to "bit.ly/21FXWl5",
      '';
    };
    having_special_symbols = {
      schemas.data = {
        validation.type = "boolean";
        example = true;
      };
      description = "having [`@` `~` `-`] symbols in url";
    };
    double_slash_redirecting = {
      schemas.data = {
        validation.type = "string";
        example = "redirected url";
      };
      schemas.result.rule = {
        "0" = "Otherwise → Legitimate";
        "1" = "The Position of the Last Occurrence of '//' in the URL";
      };
      description = ''
        https://www.virtuesecurity.com/kb/url-redirection-attack-and-defense/

        Double slash or "//" indicates that the user or the user will be redirected to another site.
        The position of the use of double slash usually appears at the sixth position as written at
        this link http://amikom.ac.id. However, if the double slash appears in the seventh
        position as https://amikom.ac.id it can be suspected as a phishing site.
      '';
    };
  }
